function UEsLos = getUAVandUEsLos(UAVBSsSet, UEsPositionOfUAVBSIncluded, UEsLosOfPossibility,r_UAVBS)
    % UAVandUEsHorDist: UAV及UE的平面歐幾里得距離
    % UAVandUEsDist: UAV及UE的歐幾里得距離
    Frequency = 2*10^9;% Frequency: 行動通訊的載波頻寬(Hz)
    Constant = 3*10^8; % constant : 光的移動速率(m/s)
    hLos = 1.6;% hLos: Los的平均訊號損失
    hNLos = 23;% hNLos: NLos的平均訊號損失
    
    for UAVBSsIndex = 1:size(UAVBSsSet(:,1),1)
        height = getHeightByArea(r_UAVBS);
        %算式(4)
        UAVandUEsHorDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex});
        UAVandUEsDist = sqrt(UAVandUEsHorDist.^2 + height^2);
        %算式(3)
        Los = 20 * log10(4*pi*Frequency*UAVandUEsDist/Constant) + hLos;
        NLoS = 20 * log10(4*pi*Frequency*UAVandUEsDist/Constant) + hNLos;
        %算式(5)
        UEsLos = UEsLosOfPossibility{UAVBSsIndex}(:,1).*(Los.') + UEsLosOfPossibility{UAVBSsIndex}(:,2).*(NLoS.');
        UEsLos
    end
end