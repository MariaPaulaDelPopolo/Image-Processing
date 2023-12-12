function [outputImage] = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped)

% grey matter = brain - (csf + whitematter)
tempImage = csfSegIm + whmSegIm;
outputImage = (skullStripped - tempImage);

end
