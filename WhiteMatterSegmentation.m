function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

mask = (skullStripped - csfSegIm);

[crossPoint, nrPeaks] = CrossPointGauss(image(image > 0), 2, 0.5);

threshold = crossPoint;
whmSegIm = (image .* mask) > threshold;
whmSegIm = whmSegIm - imcomplement(skullStripped);

outputImage = whmSegIm;

end

