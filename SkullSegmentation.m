function [outputImage] = SkullSegmentation(image, bgrSegIm)

factor = DiagonalFactor(image);

mask_background = imcomplement(bgrSegIm);

mask_background = imerode(mask_background, strel('disk', 10*factor));
erodedImage = image.*mask_background; 

mask = image > 0.1569; %& image <240;

% threshold image
thrImage = erodedImage > 0.2353 & erodedImage < 0.90;

erodedImage2 = erode_max(thrImage);
mask2 = conditional_dilation(erodedImage2, thrImage, strel('disk',1*factor,4),5*factor);
mask2 = imfill(mask2,"holes");
mask2 = imopen(mask2,strel('disk',2*factor));
mask2 = bwareafilt(logical(mask2),[140 100000000]);
mask2 = imclose(mask2,strel('disk',20*factor));
mask2 = imdilate(mask2,strel('disk',5*factor));
mask2 = imfill(mask2,"holes");

outputImage = mask;
outputImage(mask2==1)=0;

outputImage = bwareafilt(outputImage,[250 1000000000000]);



end