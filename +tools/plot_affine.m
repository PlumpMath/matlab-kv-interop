%% plot_affine
% Affine���������v���b�g����

function plot_affine( x, y, varargin )

%%
% ����

%%
%  function plot_affine(x, y, ...)
%  function plot_affine(x, y, z, ...)

% x   : x��\��Affine������
% y   : y��\��Affine������
% z   : z��\��Affine������
%       ���̈������Ȃ�����2�����Ńv���b�g����
% ... : plot_affine(..., 'PropertyName', PropertyValue)
%       �̂悤�Ƀv���p�e�B���ƒl�̑g��n��
%       �E'FaceColor'
%         �h��Ԃ��F���w�肷��
%       �E'EdgeColor'
%         ���̐F���w�肷��
%       �E'EpsilonLimit'
%         �_�~�[�ϐ��̐��𐧌�����

%%
% �v���p�e�B�� |'FaceColor'| �� |'EdgeColor'| �̏ڍׂ�
% <http://jp.mathworks.com/help/matlab/ref/patch.html#zmw57dd0e484034>
% �ɂ���B
% 
% |'EpsilonLimit'| �Ŏw�肵�����܂Ń_�~�[�ϐ������炵�Ă���v���b�g����B
% |'EpsilonLimit'| ���w�肵�ĂȂ����̓_�~�[�ϐ������炳�Ȃ��B

if ~isempty(varargin) > 0 && ~ischar(cell2mat(varargin(1)))
    dim = 3;
    z = cell2mat(varargin(1));
    varargin = varargin(2 : end);
else
    dim = 2;
end

for i = 0 : length(varargin) / 2 - 1
    % FaceColor��EdgeColor�̏ڍׂ�
    % http://jp.mathworks.com/help/matlab/ref/patch.html#zmw57dd0e484034
    if strcmp(varargin(2 * i + 1), 'FaceColor')
        fcolor = cell2mat(varargin(2 * i + 2));
    elseif strcmp(varargin(2 * i + 1), 'EdgeColor')
        ecolor = cell2mat(varargin(2 * i + 2));
    elseif strcmp(varargin(2 * i + 1), 'EpsilonLimit')
        limit = cell2mat(varargin(2 * i + 2));
    end
end

if ~exist('fcolor', 'var')
    fcolor = 'r';
end

if ~exist('ecolor', 'var')
    ecolor = 'k';
end

if exist('limit', 'var')
    [a, b] = size(x);
    if a < b
        x = x.';
    end

    [a, b] = size(y);
    if a < b
        y = y.';
    end

    if dim == 2
        mat = tools.reduce_affine([x y], limit);
        x = mat(:, 1);
        y = mat(:, 2);
    else
        [a, b] = size(z);
        if a < b
            z = z.';
        end

        mat = tools.reduce_affine([x y z], limit);
        x = mat(:, 1);
        y = mat(:, 2);
        z = mat(:, 3);
    end
end

if dim == 2
    len = max(length(x), length(y));

    if len > length(x)
        x(len) = 0.0;
    end

    if len > length(y)
        y(len) = 0.0;
    end

    px = x(1);
    py = y(1);

    for i = 2 : len
        px_ = zeros(1, length(px) * 2);
        py_ = zeros(1, length(py) * 2);

        for j = 0 : length(px) - 1
            px_(2 * j + 1) = px(j + 1) - x(i);
            py_(2 * j + 1) = py(j + 1) - y(i);
            px_(2 * j + 2) = px(j + 1) + x(i);
            py_(2 * j + 2) = py(j + 1) + y(i);
        end

        try
            k = convhull(px_, py_, 'simplify', true);
            px = px_(k(:));
            py = py_(k(:));
            hx = px;
            hy = py;
        catch
            px = px_;
            py = py_;
        end
    end

    if exist('hx', 'var')
        fill(hx, hy, fcolor, 'FaceColor', fcolor, 'EdgeColor', ecolor);
    else
        fill(0, 0, fcolor);
    end
else
    len = max(max(length(x), length(y)), length(z));

    if len > length(x)
        x(len) = 0.0;
    end

    if len > length(y)
        y(len) = 0.0;
    end

    if len > length(z)
        z(len) = 0.0;
    end

    px = x(1);
    py = y(1);
    pz = z(1);

    for i = 2 : len
        px_ = zeros(1, length(px) * 2);
        py_ = zeros(1, length(py) * 2);
        pz_ = zeros(1, length(pz) * 2);

        for j = 0 : length(px) - 1
            px_(2 * j + 1) = px(j + 1) - x(i);
            py_(2 * j + 1) = py(j + 1) - y(i);
            pz_(2 * j + 1) = pz(j + 1) - z(i);
            px_(2 * j + 2) = px(j + 1) + x(i);
            py_(2 * j + 2) = py(j + 1) + y(i);
            pz_(2 * j + 2) = pz(j + 1) + z(i);
        end

        try
            k = convhull(px_, py_, pz_, 'simplify', true);
            uk = unique(k);
            px = px_(uk);
            py = py_(uk);
            pz = pz_(uk);
            hx = px_;
            hy = py_;
            hz = pz_;
        catch
            px = px_;
            py = py_;
            pz = pz_;
        end
    end

    if exist('hx', 'var')
        trimesh(k, hx, hy, hz, 'FaceColor', fcolor, 'EdgeColor', ecolor);
    else
        trimesh(1, 0, 0, 0);
    end
end

end