% Lorenz��������kv::ode_maffine2���g���Čv�Z����T���v���v���O����
% t = 0.0����t = 30.0�܂ł�5000����
% Taylor�W�J�̎���10
% �����l [1;0;0]
% �p�����[�^ [10;28;8/3]
% Affine Arithmetic�̃_�~�[�ϐ���130�ȏ�ɂȂ�����120�Ɍ��炷

t_last = 30.0;
n = 5000;
p = 10;
init = [1;0;0];
params = [10;28;intval(8)/3];

[status, data] = kv_maffine2('lorenz-maffine2', 0.0, t_last, n, p, init, params, 120, 130);

if status == Status.Incomplete
    disp(['t = ' num2str(mid(data(end, 1))) '�܂ł����v�Z�ł��Ȃ�����']);
end

plot3(mid(data(:, 2)),mid(data(:, 3)),mid(data(:, 4)));
%PlotCube(data(:, 2), data(:, 3), data(:, 4), 'vs', 'o');