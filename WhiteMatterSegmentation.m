function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

maskedImage = image .* (skullStripped - csfSegIm);

[crossPoint, nrPeaks] = CrossPointGauss(maskedImage, 2, 0.5);

threshold = 0.9 * crossPoint;
whmSegIm = maskedImage > threshold;
whmSegIm = whmSegIm - imcomplement(skullStripped);

outputImage = whmSegIm;

end

