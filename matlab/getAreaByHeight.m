function area = getAreaByHeight(h)
    syms r
    a = 12.08;
    b = 0.11;
    etaLoS = 1.6;
    etaNLoS = 23;
    
    theta = atan(h/r);
    f =  pi*tan(theta)/(9*log(10)) + (a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/((a*exp(-b*(180*theta/pi-a))+1)^2);
    df = diff(f);
    tolerance = 1e-2;
    area = h; % 初始
    while 1
        tHeight = double(subs(f,r,area));
        if abs(tHeight) < tolerance
            break;
        end
        area = area - tHeight/double(subs(df,r,area));
    end
end