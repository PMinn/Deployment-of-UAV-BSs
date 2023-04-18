function spiralMBSPlacementAlgorithm()
    % 定義網格大小和螺旋演算法的參數
    grid_size = 100;  % 網格大小
    radius = 5;  % 螺旋演算法的半徑大小
    angle_step = 0.2;  % 螺旋演算法的角度步長
    isCounterClockwise = true; % 使用逆時針的演算法

    % 初始化基站位置和已選擇的基站數量
    MBS_positions = zeros(grid_size*grid_size, 2);
    num_MBS_selected = 0;

    % 計算螺旋演算法的參數
    num_angles = ceil(2*pi*radius/angle_step);
    d_angle = 5*pi/num_angles;
    if isCounterClockwise
        d_angle=d_angle*-1;
    end
    % 計算網格中心點的位置
    center = [grid_size/2, grid_size/2];

    % 開始進行螺旋演算法
    for i=1:num_angles
        % 計算當前角度和距離
        angle = (i-1)*d_angle;
        distance = radius*angle/(2*pi);
        
        % 計算當前位置
        x = center(1) + distance*cos(angle);
        y = center(2) + distance*sin(angle);
        
        % 判斷當前位置是否在網格範圍內
        if x > 0 && x < grid_size && y > 0 && y < grid_size
            % 判斷當前位置是否與已選擇的基站位置距離足夠大
            min_distance = inf;
            for j=1:num_MBS_selected
                distance_j = norm([x,y] - MBS_positions(j,:));
                min_distance = min(min_distance, distance_j);
            end
            if min_distance > 2*radius
                % 將當前位置添加到已選擇的基站位置列表中
                num_MBS_selected = num_MBS_selected + 1;
                MBS_positions(num_MBS_selected,:) = [x,y];
            end
        end
    end

    % 將基站位置列表中多餘的空白行刪除
    % MBS_positions(num_MBS_selected+1:end,:) = [];

    % 畫出基站的位置圖形
    scatter(MBS_positions(:,1), MBS_positions(:,2), 'filled');
    xlim([0 grid_size]);
    ylim([0 grid_size]);
    xlabel('X座標');
    ylabel('Y座標');
    title('Spiral MBS Placement Algorithm');
end