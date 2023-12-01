function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

maskedImage = image .* (skullStripped - csfSegIm);
maxVal = max(image(:));
minVal = min(image(:));
threshold = minVal + ((maxVal - minVal) / 2);

whmSegIm = maskedImage > threshold;
whmSegIm = whmSegIm - imcomplement(skullStripped);


outputImage = whmSegIm;

end

