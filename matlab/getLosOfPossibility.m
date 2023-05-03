function [UEsLosOfPossibility, UEsNLosOfPossibility] = getLosOfPossibility(UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsHigh)
    % UAVBSsHigh : UAVBS無人機的高度
    % UAVandUEsHorDist : UAV及UE的平面歐幾里得距離
    a = 12.08; % a: 環境變數
    b = 0.11; % b: 環境變數
    UEsLosOfPossibility = UEsPositionOfUAVBSIncluded; % UEsLosOfPossibility : UE的位置及Line of Sight的機率,向量形式[x,y,機率]
    UEsNLosOfPossibility = UEsPositionOfUAVBSIncluded; % UEsNLosOfPossibility : UE的位置及Non-Line of Sight的機率,向量形式[x,y,機率]

    for UAVBSsIndex=1:size(UAVBSsSet(:,1),1)%UAV個數
        % 算式(2)
        UAVandUEsHorDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex}); % 該UAV到UE的距離 [d1 d2 d3...;]
        for UAVandUEsHorDist_index=1:size(UAVandUEsHorDist,2)
            % 算式(1)
            % 2023/5/3 UAVBSsHigh未算出
            UEsLosOfPossibility{UAVBSsIndex}(UAVandUEsHorDist_index,3) = 1 / (1 + a * exp(-b * (180 / pi * atan(UAVBSsHigh / UAVandUEsHorDist(UAVandUEsHorDist_index)) - a)));
            UEsNLosOfPossibility{UAVBSsIndex}(UAVandUEsHorDist_index,3) = 1 - UEsLosOfPossibility{UAVBSsIndex}(UAVandUEsHorDist_index,3);
        end
    end
end