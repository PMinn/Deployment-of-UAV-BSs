function [ue_size, rangeOfPosition, r_UAVBS, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS, config] = loadEnvironment()
    ue_size = 600; % 生成UE的數量
    rangeOfPosition = 400; % UE座標的範圍 X介於[a b] Y介於[a b] 
    r_UAVBS = 80; % UAVBS涵蓋的範圍

    minDataTransferRateOfUEAcceptable = 10^6; % 使用者可接受的最低速率 1>2
    maxDataTransferRateOfUAVBS = 3*10^8; % 無人機回程速率上限 1.6~1.7

    config = dictionary(["bandwidth" "powerOfUAVBS" "noise"           "a"   "b"  "frequency" "constant" "etaLos" "etaNLos" "minHeight" "maxHeight" "minR"              "maxR"              ] ...
                       ,[2*10^7      0.1            4.1843795*10^-21  12.08 0.11 2*10^9      3*10^8     1.6      23        30          120         getAreaByHeight(30) getAreaByHeight(120)]);
    % bandwidth 頻寬
    % powerOfUAVBS 功率
    % noise 熱雜訊功率譜密度
    % a 環境變數
    % b 環境變數
    % frequency 行動通訊的載波頻寬(Hz)
    % constant 光的移動速率(m/s)
    % etaLos Los的平均訊號損失
    % etaNLos NLos的平均訊號損失
    % minHeight 法定最低高度
    % maxHeight 法定最高高度
end