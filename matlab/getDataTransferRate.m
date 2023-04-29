function dataTransferRates = getDataTransferRate(SINR, bandwidth)
    % SINR: 每個UE的SINR []
    % bandwidth: 頻寬

    dataTransferRates = SINR;
    dataTransferRates = dataTransferRates+1;
    dataTransferRates = log2(dataTransferRates);
    dataTransferRates = dataTransferRates*bandwidth;
end