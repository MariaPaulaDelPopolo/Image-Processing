function [outputImage] = CSFSegmentation(image, skullStripped)

maskedImage = image .* skullStripped;

[crossPoint] =CrossPointGauss(maskedImage(maskedImage > 0), 6, 0.2);

threshold = crossPoint;

csfSegIm = maskedImage < threshold;
csfSegIm = (csfSegIm - imcomplement(skullStripped)) > 0;

outputImage = csfSegIm;

end

