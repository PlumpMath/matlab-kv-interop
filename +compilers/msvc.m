%% compilers.msvc
% Visual C++�ŃR���p�C�����s�����߂̊֐�
% �����̃o�[�W�������C���X�g�[������Ă���Ƃ��͍ŐV�̂��g��

function [status, output] = msvc (sources, executable)

%%
% ����

% sources    : �\�[�X�t�@�C���̃Z���z��
% executable : ���s�t�@�C����(�ȗ���)

%%
% �߂�l

% status : �R���p�C���̏I���R�[�h(0�̂Ƃ��R���p�C������)
% output : �R���p�C���̕W���o��

%% Visual Studio��T��
% |tools\get-vs-path.bat|���g���čŐV��Visual Studio�̃C���X�g�[�����T��

%%
% <html><h3><tt>tools\get-vs-path.bat</tt>�̓���</h3></html>

% �EVS(����)0COMNTOOLS�Ƃ������O�̊��ϐ���T��
%   �E(����)�ɂ�Visual Studio�̃o�[�W�����ԍ�������
%   �E(����)��100����9�܂ŕω������čŏ��Ɍ����������̂��g��
%     �E�����ƌ��������ɂ�����
% �EVS(����)0COMNTOOLS���w���f�B���N�g������vsvars32.bat�����s����
% �EVSINSTALLDIR���ϐ��̒��g��W���o�͂ɏ����o��

%%
% <html><h3>�v���O����</h3></html>

persistent msvc_dir

if ~ischar(msvc_dir)
    [status, output] = system(fullfile('tools', 'get-vs-path.bat'));

    if status ~= 0 || isempty(output)
        error('Visual C++ not found.');
    end

    msvc_dir = fullfile(output(1:end-1), 'VC');
end

%% �R���p�C��
% |vcvarsall.bat|�����s������� |cl| �����s���ăR���p�C������

command = [ ...
    '"' fullfile(msvc_dir, 'vcvarsall.bat') '"' ...
    '&& cl /Ox /EHsc /MT /DNDEBUG /I.\include' ...
];

for i = 1:length(sources)
    command = [command ' ' char(sources(i))];
end

if nargin >= 2
    command = [command ' /Fe' executable];
end

[status, output] = system(command);

end