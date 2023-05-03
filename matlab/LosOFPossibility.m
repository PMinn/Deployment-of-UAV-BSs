function [UEsLos_P, UEsNLos_P] = LosOFPossibility(r_UAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsHigh)
    % UAVBSsHigh :UAVBS無人機的高度
    % UAVBnUEsDist : UAV及UE的歐幾里得距離
    a = 12.8 ;% a: 環境變數
    b = 0.11 ;% b: 環境變數
    UEsLos_P = UEsPositionOfUAVBSIncluded;% UEsLos_P : UE的位置及Line of Sight的機率,向量形式[x,y,機率]
    UEsNLos_P = UEsPositionOfUAVBSIncluded;% UEsNLos_P : UE的位置及Non-Line of Sight的機率,向量形式[x,y,機率]

    for UAVBSsIndex = 1:size(UAVBSsSet(:,1),1)%UAV個數
        UAVBnUEsDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex});
        for UAVBnUEsDist_Index = 1: size(UAVBnUEsDist,2)
            %算式(1)
            UEsLos_P{UAVBSsIndex}(UAVBnUEsDist_Index,3) = 1 / (1 + a * (exp(-b * (180 / pi * atan(UAVBSsHigh / UAVBnUEsDist(UAVBnUEsDist_Index)) - a))));
            UEsNLos_P{UAVBSsIndex}(UAVBnUEsDist_Index,3) = 1 - UEsLos_P{UAVBSsIndex}(UAVBnUEsDist_Index,3);
        end
    end
end