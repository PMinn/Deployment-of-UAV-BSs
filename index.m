
function index()
    % 參數
    outputDir = "./out";
    ue_size = 50;
    r_UABBS = 60;
    % 變數

    checkOutputDir(outputDir);
    locationOfUEs = UE_generator(ue_size);
    save(outputDir+"/locationOfUEs.mat","locationOfUEs")



    xArrayFromlocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromlocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列
    
    boundaryUEsSet = boundary(xArrayFromlocationOfUEs,yArrayFromlocationOfUEs,0.1); % 邊界上的UE集合
    positionOfBoundaryUEs = locationOfUEs(boundaryUEsSet,1:2);
    positionOfInnerUEs = setdiff(positionOfBoundaryUEs, locationOfUEs);
    u = positionOfBoundaryUEs(1,:);
    Pprio = zeros(1,2);
    Pprio(1,:) = u;
    Psec = setdiff(positionOfBoundaryUEs, u, 'rows');
    [new_u, new_Pprio] = localCover(r_UABBS, u, Pprio, Psec)

    disp('new_u')
    disp(new_u)
    disp('new_Pprio')
    disp(new_Pprio)

    % 繪圖
    scatter(xArrayFromlocationOfUEs,yArrayFromlocationOfUEs,20,"filled","^","b"); % 畫出所有UE
    hold on;
    plot(xArrayFromlocationOfUEs(boundaryUEsSet),yArrayFromlocationOfUEs(boundaryUEsSet),"--"); % 畫出邊界線
    x = new_u(1,1);
    y = new_u(1,2);
    rectangle('Position',[x-r_UABBS,y-r_UABBS,2*r_UABBS,2*r_UABBS],'Curvature',[1,1],'EdgeColor','m')
    hold off;
end