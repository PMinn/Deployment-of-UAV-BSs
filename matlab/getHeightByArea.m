function height = getHeightByArea(r_UAVBS)
    r = r_UAVBS;
    a = 12.08;
    b = 0.11;
    etaLoS = 1.6;
    etaNLoS = 23;
    minHeight = 30; % 法定無人機最低高度
    maxHeight = 120; % 法定無人機最高高度
    numOfDecimalPlaces = 2; % 算到小數點後幾位

    % 找到最接近的高度
    differentials = zeros(maxHeight-minHeight+1,1);
    for i=1:size(differentials,1)
        h = minHeight-1+i;
        theta = atan(h/r);
        differentials(i,1) = pi*(h/r)/(9*log(10))+(a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/(a*exp(-b*(180*theta/pi-a))+1)^2;
    end
    [~, index] = min(abs(differentials));
    height = minHeight-1+index;
    if (differentials(height-29,1)<0 && differentials(height-30,1)>0) || (differentials(height-29,1)>0 && differentials(height-30,1)<0)
        height = height-1;
    end

    % 高度貼近小數位
    decimal = 0.1; % 當前的小數位
    while numOfDecimalPlaces > 0
        differentials = zeros(11,1);
        for i=1:11
            h = height+decimal*(i-1);
            theta = atan(h/r);
            differentials(i,1) = pi*(h/r)/(9*log(10))+(a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/(a*exp(-b*(180*theta/pi-a))+1)^2;
        end
        [~, index] = min(abs(differentials));
        height = height+decimal*(index-1);
        decimal = decimal/10;
        numOfDecimalPlaces = numOfDecimalPlaces-1;
    end
end