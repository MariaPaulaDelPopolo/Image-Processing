function [thrImage, outputImage] = skull_segmentation3(image,mask_background)
mask_background = imerode(mask_background, strel('disk', 10));
erodedImage = image.*mask_background; 
sigma = 1;
%erodedImage = imgaussfilt(double(erodedImage), sigma);

mask2 = image > 0.1569; %& image <240;

% threshold image
% does not make sense since max and min is always the same 
maxVal = max(image(:));
minVal = min(image(:));
threshold1 = minVal + ((maxVal - minVal) / 5); 
threshold2 = minVal + (18 * (maxVal - minVal) / 20);
thrImage = erodedImage > 0.2353 & erodedImage < 0.90;

[erodedImage2] = erode_max(thrImage);
[mask5] = conditional_dilation2(erodedImage2, thrImage, strel('disk',1,4),5);
mask6 = imfill(mask5,"holes");
mask6 = imopen(mask6,strel('disk',2))
mask6 = bwareafilt(logical(mask6),[140 100000000]);
mask7 = imclose(mask6,strel('disk',20));
mask8 = imdilate(mask7,strel('disk',5));
mask8 = imfill(mask8,"holes");

outputImage = mask2;
outputImage(mask8==1)=0;

outputImage = bwareafilt(outputImage,[250 1000000000000]);

outputImage;
end 