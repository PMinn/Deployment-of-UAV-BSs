function arrayOfAveragePathLoss = getAveragePathLoss(UAVBSsSet, UEsPositionOfUAVBSIncluded, r_UAVBS)
    arrayOfAveragePathLoss = {};
    etaLoS = 1.6;
    etaNLoS = 23;
    frequency = 2*10^9; % 行動通訊的載波頻寬(Hz)
    constant = 3*10^8; % 光的移動速率(m/s)
    a = 12.08; % 環境變數
    b = 0.11; % 環境變數
    const1 = 20*log10(4*pi*frequency/constant); % 演算法中的常數

    etaLoS_subtract_etaNLoS = etaLoS-etaNLoS;
    heightOfUAVBS = getHeightByArea(r_UAVBS);
    heightOfUAVBS
    for i=1:size(UEsPositionOfUAVBSIncluded, 2)
        arrayOfAveragePathLoss{1, i} = [];
        for j=1:size(UEsPositionOfUAVBSIncluded{1,i}, 1)
            distanceBetweenUEandUAV = pdist2(UEsPositionOfUAVBSIncluded{1,i}(j,:), UAVBSsSet(i,:));
            theta = atan(heightOfUAVBS/distanceBetweenUEandUAV);
            arrayOfAveragePathLoss{1,i}(j,1) = etaLoS_subtract_etaNLoS/(1+a*exp(-b*(180*theta/pi-a)));
            arrayOfAveragePathLoss{1,i}(j,1) = arrayOfAveragePathLoss{1,i}(j,1) + 20*log10(distanceBetweenUEandUAV*sec(theta)) + const1 + etaNLoS;
        end
    end
end