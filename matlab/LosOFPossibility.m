function [UEsLosOfPossibility, UEsNLosOfPossibility] = LosOfPossibility(UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsHigh)
    % UAVBSsHigh :UAVBS無人機的高度
    % UAVandUEsDist : UAV及UE的歐幾里得距離
    a = 12.8 ;% a: 環境變數
    b = 0.11 ;% b: 環境變數
    UEsLosOfPossibility = UEsPositionOfUAVBSIncluded;% UEsLosOfPossibility : UE的位置及Line of Sight的機率,向量形式[x,y,機率]
    UEsNLosOfPossibility = UEsPositionOfUAVBSIncluded;% UEsNLosOfPossibility : UE的位置及Non-Line of Sight的機率,向量形式[x,y,機率]

    for UAVBSsIndex = 1:size(UAVBSsSet(:,1),1)%UAV個數
        UAVandUEsDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex});
        for UAVandUEsDist_Index = 1: size(UAVandUEsDist,2)
            %算式(1)
            UEsLosOfPossibility{UAVBSsIndex}(UAVandUEsDist_Index,3) = 1 / (1 + a * (exp(-b * (180 / pi * atan(UAVBSsHigh / UAVandUEsDist(UAVandUEsDist_Index)) - a))));
            UEsNLosOfPossibility{UAVBSsIndex}(UAVandUEsDist_Index,3) = 1 - UEsLosOfPossibility{UAVBSsIndex}(UAVandUEsDist_Index,3);
        end
    end
end