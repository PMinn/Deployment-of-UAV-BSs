function height = getHeightByArea(r_UAVBS)
    syms h
    r = r_UAVBS;
    a = 12.08;
    b = 0.11;
    etaLoS = 1.6;
    etaNLoS = 23;
    
    theta = atan(h/r);
    f =  pi*tan(theta)/(9*log(10)) + (a*b*(etaLoS-etaNLoS)*exp(-b*(180*theta/pi-a)))/((a*exp(-b*(180*theta/pi-a))+1)^2);
    df = diff(f);
    tolerance = 1e-3;
    height = r;
    while abs(double(subs(f,h,height))) > tolerance
        height = height - double(subs(f,h,height)) / double(subs(df,h,height));
    end
end