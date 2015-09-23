function [data] =  kv_maffine2(n, order, u, t_init, t_last, parameter, name)
% n ������
% order Taylor�W�J�̃I�[�_�[
% u �����l
% t_init ���͖��������

t_init = intval(0.0);

command = [
    '"' fullfile(name, 'exec.exe') '" ' ...
    '"' fillfile(name, 'output.csv') '" ' ...
    int2str(order) ' ' int2str(n)
];

itv = intval(t_last);
[a, b, c] = tools.decomp_double(inf(itv));
command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
[a, b, c] = tools.decomp_double(sup(itv));
command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];

for i = 1:length(u)
    itv = intval(u(i));    
    [a, b, c] = tools.decomp_double(inf(itv));
    command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
    [a, b, c] = tools.decomp_double(sup(itv));
    command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
end

for i = 1:length(parameter)
    itv = intval(parameter(i));    
    [a, b, c] = tools.decomp_double(inf(itv));
    command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
    [a, b, c] = tools.decomp_double(sup(itv));
    command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
end

disp(command);
system(command);

data = csvread([name '/output.csv']);

end