function area = getAreaByHeight(height)
    h = height;
    a = 12.08;
    b = 0.11;
    etaLoS = 1.6;
    etaNLoS = 23;
    numOfDecimalPlaces = 2; % 算到小數點後幾位

    % 找到最接近的半徑
    differentials = zeros(200,1);
    for r=1:size(differentials,1)
        theta = atan(h/r);
        differentials(r,1) = pi*(h/r)/(9*log(10))+(a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/(a*exp(-b*(180*theta/pi-a))+1)^2;
    end
    [~,area] = min(abs(differentials));

    % 半徑貼近小數位
    decimal = 0.1; % 當前的小數位
    while numOfDecimalPlaces > 0
        differentials = zeros(11,1);
        for i=1:11
            r = area+decimal*(i-1);
            theta = atan(h/r);
            differentials(i,1) = pi*(h/r)/(9*log(10))+(a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/(a*exp(-b*(180*theta/pi-a))+1)^2;
        end
        [~,index] = min(abs(differentials));
        area = area+decimal*(index-1);
        decimal = decimal/10;
        numOfDecimalPlaces = numOfDecimalPlaces-1;
    end
end