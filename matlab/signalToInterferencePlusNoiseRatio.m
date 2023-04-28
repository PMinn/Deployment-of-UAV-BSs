function ratio = signalToInterferencePlusNoiseRatio(arrayOfAveragePathLoss)
    % ratio: signalToInterferencePlusNoiseRatio {[] []}
    % arrayOfAveragePathLoss: 無人機j到使用者u間的平均路徑損失 {[] []}
    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 100; % 功率
    ratio = {};
    for i=size(arrayOfAveragePathLoss)
        ratio(i) = zeros();
    end
end