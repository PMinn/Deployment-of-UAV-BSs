function drawChart()
    outputDir = "./out"; % 輸出檔放置的資料夾
    
    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    % data = load(outputDir+"/satisfiedRateData.mat").satisfiedRateData;
    data = load(outputDir+"/fairnessData.mat").fairnessData;
    xlabelText = "地面使用者的數量";
    % ylabelText = "使用者滿意度";
    ylabelText = "公平性";
    % outputFile = "/satisfiedRate.jpg";
    outputFile = "/fairness.jpg";

    x = 200:200:1000;
    figure
    plot(x,data(:,2),'r-o',x,data(:,1),'b-square',x,data(:,3),'m-diamond',x,data(:,4),'g-^','LineWidth',2,'MarkerSize',10);
    xlabel(xlabelText,'FontName','標楷體');
    ylabel(ylabelText,'FontName','標楷體');
    h = legend({'本文所提方法','逆時針螺旋','kmeans(本文所提方法之結果)','kmeans(逆時針螺旋)'},'Location','southwest');
    set(h,'FontName','標楷體');
    grid on;
    exportgraphics(gcf, outputDir+outputFile, 'Resolution', 150, 'BackgroundColor', "#FFFFFF"); % 130
end