% Lorenz��������kv::odelong_qr_lohner���g���Čv�Z����T���v���v���O����
% t = 0.0����t = 20.0�܂�
% Taylor�W�J�̎���5
% �����l [1;0;0]
% �p�����[�^ [10;28;8/3]
% Affine Arithmetic�̃_�~�[�ϐ���130�ȏ�ɂȂ�����120�Ɍ��炷

t_last = 20.0;
p = 5;
init = [1;0;0];
params = [10;28;intval(8)/3];

[status, data] = kv_qr_lohner('lorenz-qr-lohner', 0.0, t_last, p, init, params);

if status == Status.Incomplete
    disp(['t = ' num2str(mid(data(end, 1))) '�܂ł����v�Z�ł��Ȃ�����']);
end

plot3(mid(data(:,2)),mid(data(:,3)),mid(data(:,4)));
