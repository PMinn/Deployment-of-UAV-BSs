function averagePathLoss = getAveragePathLoss(UAVBSsSet, UEsPositionOfUAVBSIncluded, possibility, UAVBSsR, config)
    % config.frequency: 行動通訊的載波頻寬(Hz)
    % config.constant: 光的移動速率(m/s)
    % config.etaLos: Los的平均訊號損失
    % config.etaNLos: NLos的平均訊號損失

    
    averagePathLoss = {};

    for UAVBSsIndex = 1:size(UAVBSsSet,1)
        UAVBSsHigh = getHeightByArea(UAVBSsR(UAVBSsIndex,1));

        %算式(4)
        UAVandUEsHorDist = pdist2(UAVBSsSet(UAVBSsIndex,:),UEsPositionOfUAVBSIncluded{UAVBSsIndex}); % UAV及UE的平面歐幾里得距離
        UAVandUEsDist = sqrt(UAVandUEsHorDist.^2 + UAVBSsHigh^2); % UAV及UE的歐幾里得距離

        %算式(3)
        Los = 20 * log10(4*pi*config("frequency")*UAVandUEsDist./config("constant")) + config("etaLos");
        NLoS = 20 * log10(4*pi*config("frequency")*UAVandUEsDist./config("constant")) + config("etaNLos");
        
        %算式(5)
        averagePathLoss{UAVBSsIndex} = possibility{UAVBSsIndex}(:,1).*(Los.') + possibility{UAVBSsIndex}(:,2).*(NLoS.');
    end
end