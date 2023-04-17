function [mobiles_location] = init(outputDir,ue_size)
    mobiles_location = UE_generator(ue_size);
    save(outputDir+"/mobiles_location.mat","mobiles_location")
end