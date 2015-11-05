%% compilers.gcc
% GCC�ŃR���p�C�����s�����߂̊֐�

function [status, output] = gcc (sources, executable)

%%
% ����

% sources    : �\�[�X�t�@�C���̃Z���z��
% executable : ���s�t�@�C����(�ȗ���)

%%
% �߂�l

% status : �R���p�C���̏I���R�[�h(0�̂Ƃ��R���p�C������)
% output : �R���p�C���̕W���o��

%%
% �v���O����

command = ['g++ -std=c++1z -O3 -DNDEBUG -I./include'];

first = length(command) + 1;

command = [ ...
    command ...
    zeros(1, sum(cellfun(@(x) length(x), sources)) ...
             + length(sources)) ...
];

for i = 1:length(sources)
    source = char(sources(i));
    
    last = first + length(source);
    command(first) = ' ';
    command(first + 1 : last) = source;
    first = last + 1;
end

if nargin >= 2
    command = [command ' -o ' executable];
end

command = [command ' -lstdc++'];

[status, output] = system(command);

end
