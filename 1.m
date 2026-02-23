clear all; % 清除工作区所有变量，防止旧变量干扰

% 用户输入：点电荷位置
a = input('输入点电荷的位置如[1,0,1;2,0,2]表示位置在(1,0,1),(2,0,2）：'); 

% 用户输入：电荷量及其正负性，例如 [1, -1]
Q = input('输入点电荷的电荷量，+-表示电性，如[1,-1]：'); 

% 用户输入：电场线角度间隔，控制电场线密度（角度越小线越密）
a1 = input('电场线角度间隔：'); 

q = 1; % 电荷比值，这里未使用，可以保留备用

% 设置三维显示区域的边界（各坐标轴自动留出4个单位的空白）
xmin = min(a(:,1)) - 4;
xmax = max(a(:,1)) + 4;
ymin = min(a(:,2)) - 4;
ymax = max(a(:,2)) + 4;
zmin = min(a(:,3)) - 4;
zmax = max(a(:,3)) + 4;

% 构建三维网格坐标
z = linspace(zmin, zmax); % z方向坐标
x = linspace(xmin, xmax); % x方向坐标
y = linspace(ymin, ymax); % y方向坐标
[X, Y, Z] = meshgrid(x, y, z); % 生成三维网格点

% 获取电荷数量（每一行是一个电荷）
g = size(a, 1);

% 初始化距离数组，用于存储每个网格点到各个电荷的距离
R = {};
for i = 1:g
    R{1,i} = sqrt((X - a(i,1)).^2 + (Y - a(i,2)).^2 + (Z - a(i,3)).^2); % 欧几里得距离
end

% 初始化电势为 0
U = zeros(size(X));
for i = 1:g
    U = U + Q(1,i) * (1 ./ R{1,i}); % 计算电势叠加（单位系数设为1）
end 

% 创建新图形窗口并开始绘图
figure;
hold on; % 保持图像，允许多图层叠加

% 绘制电荷点：正电为红色实心圆，负电为蓝色实心圆
for i = 1:g
    if Q(1,i) > 0
        plot3(a(i,1), a(i,2), a(i,3), 'o', 'MarkerSize', 12, ...
            'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r'); % 红色实心圆
    else
        plot3(a(i,1), a(i,2), a(i,3), 'o', 'MarkerSize', 12, ...
            'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); % 蓝色实心圆
    end
end

% 使用电势梯度计算电场矢量分量（Ex, Ey, Ez）
[Ex, Ey, Ez] = gradient(-U, x(2)-x(1), y(2)-y(1), z(2)-z(1)); 

% 设置电场线起点：起始球壳半径和角度采样
r0 = 0.1; % 电场线起点距电荷的初始距离
b = (a1:a1:360-a1) * pi / 180; % azimuth 方向角度（φ）
t = (a1:a1:360-a1) * pi / 180; % elevation 方向角度（θ）
L = length(t); % 每个电荷每个θ角生成一组φ角电场线

% 绘制电场线
for j = 1:L
    for i = 1:g 
        factor = sign(Q(1,i));  % 方向因子，正电为1，负电为-1

        % 根据球坐标变换计算电场线起点在空间的坐标
        x1{1,i} = r0 * cos(b) * sin(t(j)) + a(i,1); % x起点
        y1{1,i} = r0 * sin(b) * sin(t(j)) + a(i,2); % y起点
        z1{1,i} = r0 * sin(b) * cos(t(j)) + a(i,3); % z起点

        % 绘制电场线 streamline，使用电场分量矢量场
        h = streamline(X, Y, Z, factor*Ex, factor*Ey, factor*Ez, ...
                       x1{1,i}, y1{1,i}, z1{1,i});
        set(h, 'Color', [0.53 0.81 0.98]); % 设置为天蓝色（Sky Blue）
    end
end

% 设置图像显示属性
axis equal tight % 保持比例一致并紧凑排布
title('三维空间内电偶极子的电场线', 'fontsize', 16); % 图标题
xlabel('\itx/r (电势单位:kq/r=1)', 'fontsize', 12); % x轴标签
ylabel('\ity/r', 'fontsize', 12); % y轴标签
zlabel('\itz/r', 'fontsize', 12); % z轴标签
grid on; % 开启网格
view(3); % 设置为三维视角
