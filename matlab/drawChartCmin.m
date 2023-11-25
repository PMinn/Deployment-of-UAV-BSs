function drawChartCmin()
    outputDir = "./out"; % 輸出檔放置的資料夾
    
    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    figure;

    % data = load(outputDir+"/新增voronoi2/satisfiedRateData_varyingCmin_100times.mat").satisfiedRateData;
    % xlabelText = "Cmin(Mbps)";
    % ylabelText = "使用者滿意度(%)";
    % outputFile = "/satisfiedRate_varyingCmin_100times.jpg";

    % data = load(outputDir+"/新增voronoi2/fairnessData_varyingCmin_100times.mat").fairnessData;
    % data = data/100;
    % xlabelText = "Cmin(Mbps)";
    % ylabelText = "公平性";
    % outputFile = "/fairness_varyingCmin_100times.jpg";

    data = load(outputDir+"/新增voronoi2/dataRate_varyingCmin_100times.mat").dataRate;
    data = data / (10 ^ 6);
    xlabelText = "地面使用者的數量";
    ylabelText = "系統資料速率(Mbps)";
    outputFile = "/dataRate_varyingCmin_100times.jpg";

    x = 2:2:10;
    
    plot(x,data(:,2),'r-o',x,data(:,1),'b-square',x,data(:,3),'m-diamond',x,data(:,4),'g-^',x,data(:,5),'k-+',x,data(:,6),'c-x','LineWidth',2,'MarkerSize',10);
    xlabel(xlabelText,'FontName','標楷體');
    ylabel(ylabelText,'FontName','標楷體');
    h = legend({'SPIRAL+(K_{N}^{SPIRAL+})','逆時針螺旋(K_{N}^{SMBSP})','kmeans(K_{N}^{k-means}=K_{N}^{SMBSP})','kmeans(K_{N}^{k-means}=K_{N}^{SPIRAL+})','隨機','Voronoi'},'Location','best');
    set(h,'FontName','標楷體');
    grid on;

    % ylim([0 100]);
    % ylim([0 1]);

    % exportgraphics(gcf, outputDir + outputFile, 'Resolution', 150, 'BackgroundColor', "#FFFFFF"); % 130
end