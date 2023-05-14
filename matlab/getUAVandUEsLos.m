function UEsLos = getUAVandUEsLos(UAVBSsSet, UEsPositionOfUAVBSIncluded, UEsLosOfPossibility,r_UAVBS)
    frequency = 2*10^9;% 行動通訊的載波頻寬(Hz)
    constant = 3*10^8; % 光的移動速率(m/s)
    hLos = 1.6;% hLos: Los的平均訊號損失
    hNLos = 23;% hNLos: NLos的平均訊號損失
    UAVBSsHigh = getHeightByArea(r_UAVBS);
    UEsLos = {};

    for UAVBSsIndex = 1:size(UAVBSsSet(:,1),1)
        %算式(4)
        UAVandUEsHorDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex}); % UAV及UE的平面歐幾里得距離
        UAVandUEsDist = sqrt(UAVandUEsHorDist.^2 + UAVBSsHigh^2); % UAV及UE的歐幾里得距離
        %算式(3)
        Los = 20 * log10(4*pi*frequency*UAVandUEsDist./constant) + hLos;
        NLoS = 20 * log10(4*pi*frequency*UAVandUEsDist./constant) + hNLos;
        %算式(5)
        UEsLos{UAVBSsIndex,1} = UEsLosOfPossibility{UAVBSsIndex}(:,1).*(Los.') + UEsLosOfPossibility{UAVBSsIndex}(:,2).*(NLoS.');
    end
end