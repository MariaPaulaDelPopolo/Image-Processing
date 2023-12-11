function [outputImage] = CSFSegmentation(image, skullStripped)

maskedImage = image .* skullStripped;

count = 0;
threshold = 0;

while (count < sum(maskedImage(:) > 1) * 0.1) || (threshold < 0.1)
    
    crossPoint =CrossPointGauss(image(maskedImage > 0), 6, 0.2);
    threshold = crossPoint;
    count = sum((image(:) .* maskedImage(:)) < threshold);

end

csfSegIm = maskedImage < threshold;
csfSegIm = (csfSegIm - imcomplement(skullStripped)) > 0;

outputImage = csfSegIm;

end

