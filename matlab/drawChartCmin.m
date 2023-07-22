function drawChartCmin()
    outputDir = "./out"; % 輸出檔放置的資料夾
    
    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    figure;

    % data = load(outputDir+"/satisfiedRateData_varyingCmin_100times.mat").satisfiedRateData;
    data = load(outputDir+"/satisfiedRateData_varyingCmin_10times.mat").satisfiedRateData;
    xlabelText = "Cmin";
    ylabelText = "使用者滿意度(%)";
    % outputFile = "/satisfiedRate_varyingCmin_100times.jpg";
    outputFile = "/satisfiedRate_varyingCmin_10times.jpg";
    data = data*10;
    axis([0 6 0 100]);

    % data = load(outputDir+"/fairnessData_varyingCmin.mat").fairnessData;
    % xlabelText = "地面使用者的數量";
    % xlabelText = "Cmin";
    % ylabelText = "公平性";
    % outputFile = "/fairness_varyingCmin_100times.jpg";

    x = 1:1:6;
    
    % plot(x,data(:,2),'r-o',x,data(:,1),'b-square',x,data(:,3),'m-diamond',x,data(:,4),'g-^','LineWidth',2,'MarkerSize',10);
    plot(x,data(:,2),'r-o',x,data(:,1),'b-square','LineWidth',2,'MarkerSize',10);
    xlabel(xlabelText,'FontName','標楷體');
    ylabel(ylabelText,'FontName','標楷體');
    % h = legend({'本文所提方法','逆時針螺旋','kmeans(逆時針螺旋)','kmeans(本文所提方法之結果)'},'Location','best');
    h = legend({'本文所提方法','逆時針螺旋'},'Location','best');
    set(h,'FontName','標楷體');
    grid on;
    exportgraphics(gcf, outputDir+outputFile, 'Resolution', 150, 'BackgroundColor', "#FFFFFF"); % 130
end