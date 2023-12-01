function [outputImage] = CSFSegmentation(image, skullStripped)

maskedImage = image .* skullStripped;

maxVal = max(image(:));
minVal = min(image(:));
threshold = minVal + ((maxVal - minVal) / 6);
csfSegIm = maskedImage < threshold;
csfSegIm = csfSegIm - imcomplement(skullStripped);

outputImage = csfSegIm;

end

