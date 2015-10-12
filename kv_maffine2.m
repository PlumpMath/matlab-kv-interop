%% kv_maffine2
% make_kv_maffine2�Ő��������v���O�����Ōv�Z���Č��ʂ�Ԃ��֐�
function [data] =  kv_maffine2(name, t_init, t_last, n, order, u,  parameter, ep_reduce, ep_limit)

%%
% ����

% n         : t�̕�����([t_init, t_last]��n��������)
% order     : Taylor�W�J�̃I�[�_�[
% u         : �����l
% t_init    : ���͖��������
% ep_reduce : kv::ode_param<T>::ep_reduce
%             (�ڍׂ�http://verifiedby.me/kv/ode/index.html���Q��)
% ep_limit  : kv::ode_param<T>::ep_reduce_limit
%             (�ڍׂ�http://verifiedby.me/kv/ode/index.html���Q��)

%%

t_init = intval(0.0);

%% �v���O�����̎��s
% �v���O���������s���邽�߂̈�����p�ӂ���

command = [
    '"' fullfile(name, 'exec.exe') '" ' ...
    '"' fullfile(name, 'output.csv') '" ' ...
    int2str(order) ' ' int2str(n) ' ' int2str(ep_reduce) ' ' int2str(ep_limit)
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

%%
% �v���O���������s����
disp(command);
system(command);

%% ���s���ʂ𓾂�
data = tools.get_last_result(name);

end