clear
rm = 2; % 定义环形电流的外半径rm为2
r = 0.2:0.1:rm; % 创建一个从0.2到2的半径数组r，间隔为0.1
th = linspace(0, 2*pi, 15); % 生成极角数组th
[TH, R] = meshgrid(th, r); % 生成二维网格TH 和R
[X, Y] = pol2cart(TH, R); % 将极坐标转换为笛卡尔坐标
B = Y ./ R.^3; % 计算磁场强度B

figure
surf(X, Y, B) % 绘制磁场分布图
colormap('jet'); % 设置颜色映射
alpha(0.9); % 设置透明度
clear all; close all; clc;

% ====== 设置“磁偶极子”的两个磁荷 ======
a = [-0.5, 0, 0; 0.5, 0, 0]; % 模拟磁偶极子，两个“磁荷”
Q = [1, -1]; % +1为北极，-1为南极

a1 = input('磁场线角度间隔（如15）：'); % 极角间隔（越小越密）

% ====== 网格边界设置 ======
xmin = min(a(:,1))-4; xmax = max(a(:,1))+4;
ymin = min(a(:,2))-4; ymax = max(a(:,2))+4;
zmin = min(a(:,3))-4; zmax = max(a(:,3))+4;

% ====== 构建三维网格 ======
x = linspace(xmin, xmax, 20);
y = linspace(ymin, ymax, 20);
z = linspace(zmin, zmax, 20);
[X, Y, Z] = meshgrid(x, y, z);

% ====== 计算磁势和磁场分量（类比电势）=====
g = size(a,1); % 虚拟磁荷数
U = zeros(size(X));

for i = 1:g
Rx = X - a(i,1);
Ry = Y - a(i,2);
Rz = Z - a(i,3);
R = sqrt(Rx.^2 + Ry.^2 + Rz.^2);
R(R == 0) = eps; % 避免除以0
U = U + Q(i) ./ R;
end

% ====== 计算磁场矢量（梯度的负值）=====
[Hx, Hy, Hz] = gradient(-U, x(2)-x(1), y(2)-y(1), z(2)-z(1));
% ====== 绘图开始 ======
figure;
hold on;

% ====== 绘制两个“磁荷”球体 ======
for i = 1:g
[sx, sy, sz] = sphere(20);
if Q(i) > 0
% 北极（红）
surf(sx*0.2 + a(i,1), sy*0.2 + a(i,2), sz*0.2 + a(i,3), ...
'FaceColor', 'r', 'EdgeColor', 'none', 'FaceLighting','gouraud');
else
% 南极（蓝）
surf(sx*0.2 + a(i,1), sy*0.2 + a(i,2), sz*0.2 + a(i,3), ...
'FaceColor', 'b', 'EdgeColor', 'none', 'FaceLighting','gouraud');
end
end

% ====== 绘制磁场线 ======
r0 = 0.4; % 起点球壳半径
phi = (a1:a1:360-a1) * pi/180;
theta = (a1:a1:180-a1) * pi/180;

for i = 1:g
factor = sign(Q(i)); % 场线方向
for t = theta
x0 = r0 * cos(phi) * sin(t) + a(i,1);
y0 = r0 * sin(phi) * sin(t) + a(i,2);
z0 = r0 * cos(t) * ones(size(phi)) + a(i,3);
h = streamline(X, Y, Z, factor*Hx, factor*Hy, factor*Hz, x0, y0, z0);
set(h, 'Color', [0.5 0 1], 'LineWidth', 1.2); % 亮紫色
end
end

% ====== 图形美化 ======
axis equal;
grid on;
xlabel('x'); ylabel('y'); zlabel('z');
title('磁偶极子三维磁场线（双磁荷模型）');
view(3);
camlight headlight;
lighting gouraud;

