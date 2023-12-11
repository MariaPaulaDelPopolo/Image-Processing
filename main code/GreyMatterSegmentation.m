function [outputImage] = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped)

tempImage = (csfSegIm + whmSegIm) > 0.5;

outputImage = (skullStripped - tempImage);

end
