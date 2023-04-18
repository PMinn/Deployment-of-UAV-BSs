
function index()
    outputDir = "./out";
    ue_size = 50;

    checkOutDir(outputDir);
    mobiles_location = UE_generator(ue_size);
    save(outputDir+"/mobiles_location.mat","mobiles_location")

    scatter(mobiles_location(:,1), mobiles_location(:,2),10,"filled"); % 平面圖
end