% t = 0.0����t = 23.0�܂ł�3000����
% Taylor�W�J�̎���7
% �����l [1;0;0]
% �p�����[�^[10;28;8/3]

n = 3000;
p = 7;
init = [1;0;0];
t_last = 23.0;

data = kv_maffine2(n, p, init, 0.0, t_last, [10;28;intval(8)/3], 'lorentz-maffine2');
plot3(mid(infsup(data(:,3),data(:,4))),mid(infsup(data(:,5),data(:,6))),mid(infsup(data(:,7),data(:,8))));
%PlotCube(infsup(data(:,3),data(:,4))', infsup(data(:,5),data(:,6))', infsup(data(:,7),data(:,8))', 'vs', 'o');