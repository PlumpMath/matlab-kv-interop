classdef Status < int32
    %%
    % ���������v���O�����̎��s���ʂ�\��
    enumeration
        Succeeded(0)  % t_last�܂Ōv�Z�ł���
        Failed(1)     % �v�Z���͂��߂��Ȃ�����(�R�}���h���C����������������)
        Incomplete(2) % �r���܂ł����v�Z�ł��Ȃ�����
    end
end

