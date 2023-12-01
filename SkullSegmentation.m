function [outputImage] = SkullSegmentation(skullStripped, bgrSegIm)

maskImage = (skullStripped + bgrSegIm) > 0.5;


outputImage = imcomplement(maskImage);

end

