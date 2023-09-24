function drawChartN()
    outputDir = "./out"; % 輸出檔放置的資料夾
    figure;

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    % data = load(outputDir+"/satisfiedRateData_varyingN_100times.mat").satisfiedRateData;
    % xlabelText = "地面使用者的數量";
    % ylabelText = "使用者滿意度(%)";
    % outputFile = "/satisfiedRate_varyingN_100times.jpg";
    
    data = load(outputDir+"/fairnessData_varyingN_100times.mat").fairnessData;
    data = data/100;
    xlabelText = "地面使用者的數量";
    ylabelText = "公平性";
    outputFile = "/fairness_varyingN_100times.jpg";

    x = 200:200:1000;
    plot(x,data(:,2),'r-o',x,data(:,1),'b-square',x,data(:,3),'m-diamond',x,data(:,4),'g-^',x,data(:,5),'k-+','LineWidth',2,'MarkerSize',10);
    xlabel(xlabelText,'FontName','標楷體');
    ylabel(ylabelText,'FontName','標楷體');
    h = legend({'SPARAL+(K_{N}^{SPARAL+})','逆時針螺旋(K_{N}^{SMBSP})','kmeans(K_{N}^{k-means}=K_{N}^{SMBSP})','kmeans(K_{N}^{k-means}=K_{N}^{SPARAL+})','隨機'},'Location','best');
    set(h,'FontName','標楷體');
    grid on;

    % ylim([0 100]);
    ylim([0 1]);

    exportgraphics(gcf, outputDir + outputFile, 'Resolution', 150, 'BackgroundColor', "#FFFFFF"); % 130
end