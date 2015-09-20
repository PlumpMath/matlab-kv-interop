% t = 0.0からt = 30.0までを3000等分
% Taylor展開の次数7
% 初期値 [1;0;0]

n = 3000;
p = 7;
init = [1;0;0];
t_last = 30.0;

data = kv_maffine2(n, p, init, 0.0, t_last, [intval('0.2');intval('0.2');intval('5.7')], 'roessler-maffine2');
plot3(mid(infsup(data(:,3),data(:,4))),mid(infsup(data(:,5),data(:,6))),mid(infsup(data(:,7),data(:,8))));