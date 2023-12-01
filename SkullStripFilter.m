function [thrImage, outputImage] = SkullStripFilter(image)

erodedImage = imerode(image, strel('disk', 1));
sigma = 1;
erodedImage = imgaussfilt(double(erodedImage), sigma);

% threshold image
maxVal = max(image(:));
minVal = min(image(:));
threshold1 = minVal + ((maxVal - minVal) / 5);
threshold2 = minVal + (17 * (maxVal - minVal) / 20);
thrImage = erodedImage > threshold1 & erodedImage < threshold2;

se = strel('disk', 7);
erodedImage2 = imerode(thrImage, se);
skullStripped = conditional_dilation(erodedImage2, thrImage, strel('disk', 1), 100);

skullStripped = imdilate(skullStripped, strel('disk', 4));

sigma = 10;
skullStripped = imgaussfilt(double(skullStripped), sigma);
skullStripped = skullStripped > 0.35;


outputImage = skullStripped;

end
