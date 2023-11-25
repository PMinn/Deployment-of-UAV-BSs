function test()
    outputDir = "./out"; % 輸出檔放置的資料夾
    satisfiedRateData = load(outputDir+"/新增隨機/satisfiedRateData_varyingCmin_100times.mat").satisfiedRateData;
    fairnessData = load(outputDir+"/新增隨機/fairnessData_varyingCmin_100times.mat").fairnessData;
    
    satisfiedRateData2 = load(outputDir+"/t/satisfiedRateData_varyingCmin_100times.mat").satisfiedRateData;
    fairnessData2 = load(outputDir+"/t/fairnessData_varyingCmin_100times.mat").fairnessData;

    satisfiedRateData(:,6) = satisfiedRateData2(:,6); 
    fairnessData(:,6) = fairnessData2(:,6); 
    satisfiedRateData
    fairnessData
    save(outputDir+"/新增voronoi/satisfiedRateData_varyingCmin_100times.mat", "satisfiedRateData");
    save(outputDir+"/新增voronoi/fairnessData_varyingCmin_100times.mat", "fairnessData");
end