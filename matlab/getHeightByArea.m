function height = getHeightByArea(r_UAVBS)
    r = r_UAVBS;
    a = 12.08;
    b = 0.11;
    etaLoS = 1.6;
    etaNLoS = 23;
    maxHeight = 120; % 法定無人機最高高度
    numOfDecimalPlaces = 2; % 算到小數點後幾位

    % 找到最接近的高度
    differentials = zeros(maxHeight,1);
    for h=1:size(differentials,1)
        theta = atan(h/r);
        differentials(h,1) = pi*tan(h/r)/(9*log(10))+(a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/(a*exp(-b*(180*theta/pi-a))+1)^2;
    end
    [~,height] = min(abs(differentials));

    % 高度貼近小數位
    decimal = 0.1; % 當前的小數位
    while numOfDecimalPlaces > 0
        differentials = zeros(11,1);
        for i=1:11
            h = height+decimal*(i-1);
            theta = atan(h/r);
            differentials(i,1) = pi*tan(h/r)/(9*log(10))+(a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/(a*exp(-b*(180*theta/pi-a))+1)^2;
        end
        [~,index] = min(abs(differentials));
        height = height+decimal*(index-1);
        decimal = decimal/10;
        numOfDecimalPlaces = numOfDecimalPlaces-1;
    end
end