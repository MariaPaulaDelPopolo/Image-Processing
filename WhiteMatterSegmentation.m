function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

mask = (skullStripped - csfSegIm);

count = 0;
threshold = 0;

while (count < sum(mask(:) > 1) * 0.3) || (threshold < 0.2)
    
    crossPoint = CrossPointGauss(image(mask > 0), 2, 0.4);
    threshold = crossPoint;
    count = sum((image(:) .* mask(:)) < threshold);

end

whmSegIm = (image .* mask) > threshold;
outputImage = whmSegIm;

end

