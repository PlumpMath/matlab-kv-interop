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

% t = 30.0�ł̌v�Z���ʂ�\��Affine���������v���b�g����
% �_�~�[�ϐ��̐��������ƕ`�悪�I���Ȃ��̂�17�Ɍ��炵�ăv���b�g����
figure;
subplot(2, 2, 1);
tools.plot_affine( ...
    a(:, 1), a(:, 2), a(:, 3), ...
    'FaceColor', 'w', 'EdgeColor', 'flat', ...
    'EpsilonLimit', 17 ...
);
xlabel('x');
ylabel('y');
zlabel('z');

% 2�����Ńv���b�g����΃_�~�[�ϐ��������Ă��v���b�g�ł���
subplot(2, 2, 2);
tools.plot_affine(a(:, 1), a(:, 2), 'FaceColor', 'r');
xlabel('x');
ylabel('y');
subplot(2, 2, 3);
tools.plot_affine(a(:, 2), a(:, 3), 'FaceColor', 'g');
xlabel('y');
ylabel('z');
subplot(2, 2, 4);
tools.plot_affine(a(:, 3), a(:, 1), 'FaceColor', 'b');
xlabel('z');
ylabel('x');