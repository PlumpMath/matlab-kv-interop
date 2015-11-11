%% kv_qr_lohner
% make_kv_qr_lohner�Ő��������v���O�����Ōv�Z���Č��ʂ�Ԃ��֐�

function [status, data] =  kv_qr_lohner (name, t_init, t_last, order, u, parameters)

%%
% ����

% n         : t�̕�����([t_init, t_last]��n��������)
% order     : Taylor�W�J�̃I�[�_�[
% u         : �����l
% t_init    : ���͖��������

%%
% �߂�l

% status ; �v�Z�ł������ǂ�����\��
%          �EState.Succeeded
%            t_last�܂Ōv�Z�ł���
%          �EState.Failed
%            �v�Z���n�߂��Ȃ�����
%            �E�R�}���h���C����������������(���C�u�����̃o�O)
%            �E�o�̓t�@�C�����J���Ȃ�����(���C�u�����̃o�O�ł͂Ȃ�)
%            �ڍׂ̓R�}���h�E�B���h�E�ɏo�͂����
%          �EState.Incomplete
%            �r���܂ł����v�Z�ł��Ȃ�����
% data   : �v�Z���ʂ�\����ԍs��
%          1��ڂ�t�ő��̗��u

%%

t_init = intval(0.0);

%% �v���O�����̎��s
% �v���O���������s���邽�߂̈�����p�ӂ���

command = [
    '"' fullfile('.', name, 'exec') '" ' ...
    '"' fullfile('.', name, 'output.csv') '" ' ...
    int2str(order)
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

for i = 1:length(parameters)
    itv = intval(parameters(i));    
    [a, b, c] = tools.decomp_double(inf(itv));
    command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
    [a, b, c] = tools.decomp_double(sup(itv));
    command = [command ' ' int2str(a) ' ' int2str(b) ' ' int2str(c)];
end

%%
% �v���O���������s����

disp(command);
[status, out] = system(command);

%%
% �Ō�܂Ōv�Z�ł��Ȃ������Ƃ��̓��b�Z�[�W���o�͂���
if status ~= Status.Succeeded
        disp(out);

        if status ~= Status.Incomplete
            error(['failed (status: ' int2str(status) ')']);
        end
end

%% ���s���ʂ𓾂�
data = tools.get_latest_result(name);

end