% t = 0.0����t = 30.0�܂ł�3000����
% Taylor�W�J�̎���7
% �����l [1;0;0]

n = 3000;
p = 7;
init = [1;0;0];
t_last = 30.0;

data = kv_maffine2(n, p, init, 0.0, t_last, [intval('0.2');intval('0.2');intval('5.7')], 'roessler-maffine2');
plot3(mid(infsup(data(:,3),data(:,4))),mid(infsup(data(:,5),data(:,6))),mid(infsup(data(:,7),data(:,8))));