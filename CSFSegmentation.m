function [outputImage] = CSFSegmentation(image, skullStripped)

maskedImage = image .* skullStripped;

[crossPoint, nrPeaks] =CrossPointGauss(maskedImage, 6, 0.2);

threshold = crossPoint;

csfSegIm = maskedImage < threshold;
csfSegIm = csfSegIm - imcomplement(skullStripped);

outputImage = csfSegIm;

end

