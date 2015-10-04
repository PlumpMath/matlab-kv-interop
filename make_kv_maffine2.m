function make_kv_maffine2(u, f, parameter, name, compiler)
% make verification program
% 

if nargin <= 4
    disp('the argument ''compiler'' of make_kv is empty.');
    disp('use Microsoft Visual C++ compiler as default.');
    compiler = @compilers.msvc;
end

build_tools(compiler);

mkdir(name);

source = fullfile(name, 'main.cpp');
executable = fullfile(name, 'exec.exe');

matlab2cpp = fullfile('tools', 'MATLAB2C++.exe');

dim = length(f);

%--------------------------------------------------------------------------
% generate source file
%--------------------------------------------------------------------------

disp(['generating source file (file name: ' source ')']);

fp = fopen(source, 'wt');

% preprocessors

fprintf(fp, '// eliminate deprecation warnings\n');
fprintf(fp, '#if defined(_MSC_VER)\n');
fprintf(fp, '# define _CRT_SECURE_NO_WARNINGS\n');
fprintf(fp, '#endif\n\n');
fprintf(fp, '#include <cstdlib>\n');
fprintf(fp, '#include <iostream>\n');
fprintf(fp, '#include <fstream>\n');
fprintf(fp, '#include <utility>\n\n');
fprintf(fp, '#include <boost/numeric/ublas/vector.hpp>\n\n');
fprintf(fp, '#include <kv/affine.hpp>\n');
fprintf(fp, '#include <kv/rdouble.hpp>\n');
fprintf(fp, '#include <kv/ode-maffine2.hpp>\n');
fprintf(fp, '#include <kv/ode-param.hpp>\n');
fprintf(fp, '#include <kv/ode-callback.hpp>\n\n');
fprintf(fp, '#include <conv.hpp>\n\n');

% function

fprintf(fp, 'struct func{\n');

if length(parameter) > 0
    % definition of members
    fprintf(fp, '\t::kv::interval<double> ');
    
    for i = 1:length(parameter)
        if i ~= 1
            fprintf(fp, ', ');
        end
        fprintf(fp, char(parameter(i)));
    end
    
    fprintf(fp, ';\n\n');
    
    % constructor
    fprintf(fp, '\tfunc(\n');
    
    for i = 1:length(parameter)
        fprintf(fp, ['\t\tconst ::kv::interval<double> &' char(parameter(i))]);
        if i ~= length(parameter)
            fprintf(fp, ',');
        end
        fprintf(fp, '\n');
    end
    
    fprintf(fp, '\t)\n');
    fprintf(fp, '\t\t: ');
    
    for i = 1:length(parameter)
        if i ~= 1
            fprintf(fp, '\t\t, ');
        end
        fprintf(fp, [char(parameter(i)) '(' char(parameter(i)) ')\n']);
    end
    
    fprintf(fp, '\t{\n\t}\n\n');
end

fprintf(fp, '\ttemplate<typename T>\n');
fprintf(fp, '\t::boost::numeric::ublas::vector<T> operator()(\n');
fprintf(fp, '\t\tconst ::boost::numeric::ublas::vector<T> &u,\n');
fprintf(fp, '\t\tconst T &t\n');
fprintf(fp, '\t) const\n');
fprintf(fp, '\t{\n');

for i = 1:length(u)
    fprintf(fp, ['\t\tconst T &' char(u(i)) ' = u(' int2str(i - 1) ');\n']);
end

fprintf(fp, '\n');

fprintf(fp, ['\t\t::boost::numeric::ublas::vector<T> return_value(' int2str(dim) ');\n\n']);

for i = 1:length(f)
    [status, out] = system([matlab2cpp ' "' char(f(i)) '"']);
    
    if status ~= 0
        disp(['failed to parse function "' char(f(i)) '".']);
        disp(out);
        return
    end
    
    fprintf(fp, ['\t\treturn_value(' int2str(i - 1) ') = ' out ';\n']);
end

fprintf(fp, '\n\t\treturn return_value;\n');
fprintf(fp, '\t}\n');
fprintf(fp, '};\n\n');

% main

% �����l�Ǝ��Ԃ̏I�_�ƃp�����[�^�͋�Ԃŕ\����ăR�}���h���C����������󂯎��
% �R�}���h���C�������ɂ͉��[�Ə�[���ꂼ��𕄍��r�b�g(0��1)�A�w����(�����t������)�A������(64�r�b�g�ȓ��̐���)��3�ɕ����������̂�n��

fprintf(fp, 'int main(int argc, char **argv)\n');
fprintf(fp, '{\n');

fprintf(fp, ['\tif(argc < ' int2str(2 + 2 * 3 * (1 + length(u) + length(parameter))) '){\n']);
fprintf(fp, '\t\t::std::cerr << "invalid argument" << ::std::endl;\n');
fprintf(fp, '\t}\n\n');

fprintf(fp, '\t::std::ofstream ofs(argv[1]);\n');
fprintf(fp, '\tofs.setf(ofs.scientific);\n');
fprintf(fp, '\tofs.precision(17);\n\n');

fprintf(fp, '\t::kv::interval<double> t_last(\n');
fprintf(fp, '\t\t::todouble(::std::strtol(argv[4], nullptr, 10), ::std::strtol(argv[5], nullptr, 10), ::std::strtoull(argv[6], nullptr, 10)),\n');
fprintf(fp, '\t\t::todouble(::std::strtol(argv[7], nullptr, 10), ::std::strtol(argv[8], nullptr, 10), ::std::strtoull(argv[9], nullptr, 10)));\n\n');

fprintf(fp, ['\t::boost::numeric::ublas::vector<::kv::affine<double>> u(' int2str(length(u)) ');\n\n']);

for i = 1:length(u)
    fprintf(fp, [ ...
        '\tu(' int2str(i - 1) ') = ::kv::interval<double>(\n' ...
        '\t\t::todouble(::std::strtol(argv[' int2str(i * 6 + 4) '], nullptr, 10), ::std::strtol(argv[' int2str(i * 6 + 5) '], nullptr, 10), ::std::strtoull(argv[' int2str(i * 6 + 6) '], nullptr, 10)),\n' ...
        '\t\t::todouble(::std::strtol(argv[' int2str(i * 6 + 7) '], nullptr, 10), ::std::strtol(argv[' int2str(i * 6 + 8) '], nullptr, 10), ::std::strtoull(argv[' int2str(i * 6 + 9) '], nullptr, 10)));\n\n']);
end

bias = 6 * length(u) + 3;

for i = 1:length(parameter)
    fprintf(fp, [ ...
        '\t::kv::interval<double> ' char(parameter(i)) '(\n' ...
        '\t\t::todouble(::std::strtol(argv[' int2str(i * 6 + bias + 1) '], nullptr, 10), ::std::strtol(argv[' int2str(i * 6 + bias + 2) '], nullptr, 10), ::std::strtoull(argv[' int2str(i * 6 + bias + 3) '], nullptr, 10)),\n' ...
        '\t\t::todouble(::std::strtol(argv[' int2str(i * 6 + bias + 4) '], nullptr, 10), ::std::strtol(argv[' int2str(i * 6 + bias + 5) '], nullptr, 10), ::std::strtoull(argv[' int2str(i * 6 + bias + 6) '], nullptr, 10)));\n\n']);
end

clear bias;

fprintf(fp, '\tofs << "0.0,0.0"');

for i = 1:length(u)
    fprintf(fp, ['\n\t    << '','' << to_interval(u(' int2str(i - 1) ')).lower() << '','' << to_interval(u(' int2str(i - 1) ')).upper()']);
end

fprintf(fp, ' << ::std::endl;\n\n');

fprintf(fp, '\tint itermax = ::std::strtol(argv[3], nullptr, 10);\n');
fprintf(fp, '\tint order = ::std::strtol(argv[2], nullptr, 10);\n');
fprintf(fp, '\t::kv::interval<double> t1(0.0);\n');

fprintf(fp, '\tfunc f(');

for i = 1:length(parameter)
    if i ~= 1
        fprintf(fp, ', ');
    end
    fprintf(fp, char(parameter(i)));
end

fprintf(fp, ');\n');
fprintf(fp, '\tint r;\n\n');

fprintf(fp, '\tfor(int i = 0; i < itermax; i++){\n');
fprintf(fp, '\t\t::kv::interval<double> t2 = t_last * (i + 1) / itermax;\n\n');

fprintf(fp, '\t\tr = ::kv::ode_maffine2(\n');
fprintf(fp, '\t\t\tf,\n');
fprintf(fp, '\t\t\tu,\n');
fprintf(fp, '\t\t\tt1,\n');
fprintf(fp, '\t\t\tt2,\n');
fprintf(fp, '\t\t\t::kv::ode_param<double>().set_order(order).set_autostep(false).set_ep_reduce(1).set_ep_reduce_limit(3));\n\n');

fprintf(fp, '\t\tofs << t2.lower() << '','' << t2.upper();\n');

for i = 1:length(u)
    fprintf(fp, '\t\tofs << '','';\n');
    fprintf(fp, ['\t\t::kv::rop<double>::print_down(to_interval(u(' int2str(i - 1) ')).lower(), ofs);\n']);
    fprintf(fp, '\t\tofs << '','';\n');
    fprintf(fp, ['\t\t::kv::rop<double>::print_up(to_interval(u(' int2str(i - 1) ')).upper(), ofs);\n']);
end

fprintf(fp, '\t\tofs << ::std::endl;\n\n');

fprintf(fp, '\t\tif(r != 2) break;\n\n');

fprintf(fp, '\t\tt1 = t2;\n');
fprintf(fp, '\t}\n');
fprintf(fp, '\treturn (r != 0) ? 0 : 1;\n');
fprintf(fp, '}\n');

fclose(fp);

disp('source file was generated.');
disp('compiling...');

[status, out] = compiler({source}, executable);

if status ~= 0
    disp('compilation failed.');
    disp(out);
else
    disp('compilation succeeded.');
end

!del *.obj

end