function [UAVBSsSet, UEsPositionOfUAVBSIncluded] = spiralMBSPlacementAlgorithm(isCounterClockwise, locationOfUEs, r_UAVBS, angle)
    % isCounterClockwise: 是否用逆時針演算(否則為順時針)
    % locationOfUEs: 所有UE的位置 []
    % r_UAVBS: 無人機的涵蓋範圍半徑
    % UAVBSsSet: 所有無人機的位置 []
    % angle: 旋轉排序的起始角度(0~360deg)

    % Initialization
    uncoveredUEsSet = locationOfUEs;
    UAVBSsSet = [];
    centerUE = [];
    UEsPositionOfUAVBSIncluded = {};

    % 演算法第1行
    [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(isCounterClockwise, uncoveredUEsSet, angle); % 找出邊緣並以逆時針排序
    while ~isempty(uncoveredUEsSet)
        % 演算法第2行
        uncoveredInnerUEsSet = setdiff(uncoveredUEsSet, uncoveredBoundaryUEsSet, 'rows');
        centerUE = uncoveredBoundaryUEsSet(1,:);

        % 演算法第3行、演算法第4行
        % 涵蓋邊緣點、涵蓋內點
        [secondLocalCoverU, secondLocalCoverPprio] = cover(r_UAVBS, centerUE, uncoveredBoundaryUEsSet, uncoveredInnerUEsSet);
        
        % 演算法第5行
        % 更新結果
        UAVBSsSet(size(UAVBSsSet,1)+1,:) = secondLocalCoverU;
        uncoveredUEsSet = setdiff(uncoveredUEsSet, secondLocalCoverPprio, 'rows');

        % 演算第6行
        % 以不更改排序的情況下移除未覆蓋邊緣集合裡已覆蓋的邊緣點
        uncoveredBoundaryUEsSet(ismember(uncoveredBoundaryUEsSet, secondLocalCoverPprio, 'rows'),:) = [];

        UEsPositionOfUAVBSIncluded{1,size(UEsPositionOfUAVBSIncluded,2)+1} = secondLocalCoverPprio;

        if isempty(uncoveredBoundaryUEsSet)
            [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(isCounterClockwise, uncoveredUEsSet, angle);
        end
    end
end