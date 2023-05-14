function [UEsLosOfPossibility] = getLosOfPossibility(UAVBSsSet, UEsPositionOfUAVBSIncluded, r_UAVBS)
    % UAVBSsHigh: UAVBS無人機的高度
    % UAVandUEsHorDist: UAV及UE的平面歐幾里得距離
    a = 12.08; % a: 環境變數
    b = 0.11; % b: 環境變數
    % UEsLosOfPossibility: UE的位置及Line of Sight的機率,向量形式[Los,NLos;]

    for i=1:size(UAVBSsSet(:,1),1)%UAV個數
        % 算式(2)
        UAVandUEsHorDist = pdist2(UAVBSsSet(i,:),UEsPositionOfUAVBSIncluded{i}); % 該UAV到UE的距離 [d1 d2 d3...;]
         UAVBSsHigh = getHeightByArea(r_UAVBS);
        for j=1:size(UAVandUEsHorDist,2)
            % 算式(1)
            UEsLosOfPossibility{i}(j,1) = 1 / (1 + a * exp(-1*b * (180 * atan(UAVBSsHigh / UAVandUEsHorDist(j)) / pi - a)));
            UEsLosOfPossibility{i}(j,2) = 1 - UEsLosOfPossibility{i}(j,1);
        end
    end
end