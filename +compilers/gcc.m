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

for i = 1:length(sources)
    command = [command ' ' char(sources(i))];
end

if nargin >= 2
    command = [command ' -o ' executable];
end

command = [command ' -lstdc++'];

[status, output] = system(command);

end
