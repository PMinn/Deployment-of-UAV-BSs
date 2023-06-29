function SINR = getSINR(UAVBSsSet, locationOfUEs, indexArrayOfUEsServedByUAVBS, L, UEsIndexOfUAVBSIncluded, arrayOfBandwidths, config)
    SINR = zeros(size(locationOfUEs,1),1); % 每台UAVBS的SINR 

    for i=1:size(SINR,1)
        numerator = 0;
        denominator = 0;
        bandwidth = 0;
        for j=1:size(UAVBSsSet,1)
            if indexArrayOfUEsServedByUAVBS(i,1) == j
                numerator = config("powerOfUAVBS")*10^(-L(i,indexArrayOfUEsServedByUAVBS(i,1))/10);
                bandwidth = arrayOfBandwidths(j,1);
            elseif ismember(i, UEsIndexOfUAVBSIncluded{j,1})
                denominator = denominator+10^(-L(i,indexArrayOfUEsServedByUAVBS(i,1))/10);
            end
        end
        denominator = denominator*config("powerOfUAVBS")+bandwidth*config("noise");
        SINR(i,1) = numerator/denominator;
    end
end