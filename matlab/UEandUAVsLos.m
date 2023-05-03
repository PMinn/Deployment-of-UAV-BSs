function  UEandUAVsLos( UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsHigh, UEsLosOfPossibility, UEsNLosOfPossibility)
    % UAVandUEsHorDist : UAV及UE的平面歐幾里得距離
    % UAVandUEsDist : UAV及UE的歐幾里得距離
    Frequency = 2*10^9;%Frequency : 行動通訊的載波頻寬(Hz)
    Constant = 3*10^8; %constant  : 光的移動速率(m/s)
    hLos = 1.6;%HLos : Los的平均訊號損失
    hNLos = 23;%HNLos : NLos的平均訊號損失
    for UAVBSsIndex = 1:size(UAVBSsSet(:,1),1)%UAV個數
        %算式(4)
        UAVandUEsHorDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex});
        UAVandUEsDist = sqrt(UAVandUEsHorDist.^2 + UAVBSsHigh.^2);
        %算式(3)
        Los = 20 * log10(4*pi*Frequency*UAVandUEsDist/Constant) + hLos;
        NLoS = 20 * log10(4*pi*Frequency*UAVandUEsDist/Constant) + hNLos;
        %算式(5)
        %size(Los.')
        %size(UEsLosOfPossibility{UAVBSsIndex}(:,3)
        totallos = UEsLosOfPossibility{UAVBSsIndex}(:,3).*(Los.') + UEsNLosOfPossibility{UAVBSsIndex}(:,3).*(NLoS.');
        totallos
    end

end