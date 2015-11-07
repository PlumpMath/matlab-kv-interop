% Roessler��������kv::ode_maffine2���g���Čv�Z����T���v���v���O����
% t = 0.0����t = 30.0�܂ł�3000����
% Taylor�W�J�̎���7
% �����l [1;0;0]
% �p�����[�^ [0.2;0.2;5.7]
% Affine Arithmetic�̃_�~�[�ϐ���18�ȏ�ɂȂ�����20�Ɍ��炷

t_last = 100.0;
n = 3000;
p = 7;
init = [1;0;0];
params = [intval('0.2');intval('0.2');intval('5.7')];

[status, data, a] = kv_maffine2('roessler-maffine2', 0.0, t_last, n, p, init, params, 18, 20);

if status == Status.Incomplete
    disp(['t = ' num2str(mid(data(end, 1))) '�܂ł����v�Z�ł��Ȃ�����']);
end

plot3(mid(data(:, 2)),mid(data(:, 3)),mid(data(:, 4)));

% Affine���������v���b�g����
figure;
tools.plot_affine(a(:,1), a(:,2), a(:,3), 'FaceColor', 'w', 'EdgeColor', 'flat');