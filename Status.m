classdef Status < int32
    %%
    % ���������v���O�����̎��s���ʂ�\��
    enumeration
        Succeeded(0)  % t_last�܂Ōv�Z�ł���
        Failed(1)     % �v�Z���͂��߂��Ȃ�����
                      % �E�R�}���h���C����������������
                      % �E�o�͗p�̃t�@�C�����J���Ȃ�����
        Incomplete(2) % �r���܂ł����v�Z�ł��Ȃ�����
    end
end

