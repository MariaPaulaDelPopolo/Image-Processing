function [outputImage] = CSFSegmentation(image, skullStripped)

maskedImage = image .* skullStripped;

imhist(maskedImage);
ylim([0, 500]);

maxVal = max(image(:));
minVal = min(image(:));
threshold = ((maxVal - minVal) / 6);
csfSegIm = maskedImage < threshold;
csfSegIm = csfSegIm - imcomplement(skullStripped);

outputImage = csfSegIm;

end

