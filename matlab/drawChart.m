function drawChart()
    outputDir = "./out"; % 輸出檔放置的資料夾
    
    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    satisfiedRateData = load(outputDir+"/satisfiedRateData.mat").satisfiedRateData;
    x = 200:200:1000;
    figure
    plot(x,satisfiedRateData(:,2),'r-o',x,satisfiedRateData(:,1),'b-square',x,satisfiedRateData(:,3),'m-diamond',x,satisfiedRateData(:,4),'g-^','LineWidth',2,'MarkerSize',10);
    xlabel('地面使用者的數量','FontName','標楷體');
    ylabel('使用者滿意度','FontName','標楷體');
    h = legend({'本文所提方法','逆時針螺旋','kmeans(本文所提方法之結果)','kmeans(逆時針螺旋)'},'Location','southwest');
    set(h,'FontName','標楷體');
    grid on;
    exportgraphics(gcf, outputDir+"/satisfiedRate.jpg", 'Resolution', 150, 'BackgroundColor', "#FFFFFF"); % 130
end