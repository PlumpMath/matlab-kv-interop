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

[status, data, a] = kv_maffine2('lorenz-maffine2', 0.0, t_last, n, p, init, params, 120, 130);

if status == Status.Incomplete
    disp(['t = ' num2str(mid(data(end, 1))) '�܂ł����v�Z�ł��Ȃ�����']);
end

figure;
plot3(mid(data(:, 2)),mid(data(:, 3)),mid(data(:, 4)));
xlabel('x');
ylabel('y');
zlabel('z');

% t = 30.0�ł̌v�Z���ʂ�\��Affine���������v���b�g����
% �_�~�[�ϐ��̐��������ƕ`�悪�I���Ȃ��̂�17�܂Ō��炵�ăv���b�g����
figure;
subplot(2, 2, 1);
tools.plot_affine(a(:, 1), a(:, 2), a(:, 3), 'FaceColor', 'flat', 'EpsilonLimit', 17);
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

%PlotCube(data(:, 2), data(:, 3), data(:, 4), 'vs', 'o');