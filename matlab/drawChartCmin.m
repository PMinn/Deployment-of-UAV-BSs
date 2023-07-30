function drawChartCmin()
    outputDir = "./out"; % 輸出檔放置的資料夾
    
    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    figure;

    data = load(outputDir+"/10m/satisfiedRateData_varyingCmin_100times.mat").satisfiedRateData;
    xlabelText = "Cmin(Mbps)";
    ylabelText = "使用者滿意度(%)";
    outputFile = "/10m/satisfiedRate_varyingCmin_100times.jpg";

    % data = load(outputDir+"/10m/fairnessData_varyingCmin_100times.mat").fairnessData;
    % data = data/100;
    % xlabelText = "Cmin(Mbps)";
    % ylabelText = "公平性";
    % outputFile = "/10m/fairness_varyingCmin_100times.jpg";

    x = 1:1:6;
    
    plot(x,data(:,2),'r-o',x,data(:,1),'b-square',x,data(:,3),'m-diamond',x,data(:,4),'g-^','LineWidth',2,'MarkerSize',10);
    xlabel(xlabelText,'FontName','標楷體');
    ylabel(ylabelText,'FontName','標楷體');
    h = legend({'SPARAL+(K_{N}^{SPARAL+})','逆時針螺旋(K_{N}^{SMBSP})','kmeans(K_{N}^{k-means}=K_{N}^{SMBSP})','kmeans(K_{N}^{k-means}=K_{N}^{SPARAL+})'},'Location','best');
    set(h,'FontName','標楷體');
    grid on;
    exportgraphics(gcf, outputDir + outputFile, 'Resolution', 150, 'BackgroundColor', "#FFFFFF"); % 130
end