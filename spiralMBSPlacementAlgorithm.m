function [UAVBSsSet, UAVBSsRange] = spiralMBSPlacementAlgorithm(isCounterClockwise, locationOfUEs, r_UAVBS, angle)
    % isCounterClockwise: 是否用逆時針演算(否則為順時針)
    % locationOfUEs: 所有UE的位置 []
    % r_UAVBS: 無人機的涵蓋範圍半徑
    % UAVBSsSet: 所有無人機的位置 []
    % UAVBSsRange: 所有無人機涵蓋著的的位置 {[] [];}
    % angle: 旋轉排序的起始角度(0~360deg)

    % Initialization(修改過)
    uncoveredUEsSet = locationOfUEs;
    UAVBSsSet = [];
    UAVBSsRange = {};
    % m = 1;
    centerUE = [];

    % Algorithm
    % 演算法第1行(修改過)
    [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(isCounterClockwise, uncoveredUEsSet, angle); % 找出邊緣並以逆時針排序
    while ~isempty(uncoveredUEsSet)
        % 演算法第2行(修改過)
        uncoveredInnerUEsSet = setdiff(uncoveredUEsSet, uncoveredBoundaryUEsSet, 'rows');
        centerUE = uncoveredBoundaryUEsSet(1,:);
        % if m == 1
        %     centerUE = uncoveredBoundaryUEsSet(1,:);
        % end

        % 演算法第3行
        % 涵蓋邊緣點
        [firstLocalCoverU, firstLocalCoverPprio] = localCover(r_UAVBS, centerUE, centerUE, setdiff(uncoveredBoundaryUEsSet, centerUE, 'rows'));
        newBoundaryUEsSet = firstLocalCoverPprio;

        % 演算法第4行
        % 涵蓋內點
        [secondLocalCoverU, secondLocalCoverPprio] = localCover(r_UAVBS, firstLocalCoverU, newBoundaryUEsSet, uncoveredInnerUEsSet);
        newPositionOfUAVBS = secondLocalCoverU; % 最後的涵蓋中心 即為UAVBS的座標
        newUEsSet = secondLocalCoverPprio; % 最後的涵蓋範圍
        
        % 演算法第5行(修改過)
        % 更新結果
        UAVBSsSet(size(UAVBSsSet,1)+1,:) = newPositionOfUAVBS;
        UAVBSsRange{size(UAVBSsRange,2)+1} = newUEsSet;
        uncoveredUEsSet = setdiff(uncoveredUEsSet, newUEsSet, 'rows');
        % m = m+1;

        % 演算第6行(修改過)
        % 以不更改排序的情況下移除未覆蓋邊緣集合裡已覆蓋的邊緣點
        commonRows = ismember(uncoveredBoundaryUEsSet, secondLocalCoverPprio,'rows');
        uncoveredBoundaryUEsSet(commonRows,:) = [];
        if ~isempty(uncoveredBoundaryUEsSet)
            centerUE = uncoveredBoundaryUEsSet(1,:);
        else
            [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(isCounterClockwise, uncoveredUEsSet, angle);
        end
    end
end