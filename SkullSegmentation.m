function [brainMask, outputImage] = SkullSegmentation(image, bgrSegIm)

D = DiagonalFactor(image);

mask_background = imcomplement(bgrSegIm);

mask_background = imerode(mask_background, strel('disk', round(0.0333*D)));
erodedImage = image.*mask_background; 

%threshold = graythresh(image)/2;
mask = image > 0.1569;

% threshold image
thrImage = erodedImage > 0.2353 & erodedImage < 0.90;

erodedImage2 = erode_max(thrImage,D);
mask2 = conditional_dilation(erodedImage2, thrImage, strel('disk',round(0.0033*D),4),round(0.0167*D));
mask2 = imfill(mask2,"holes");
mask2 = imopen(mask2,strel('disk',round(0.0067*D)));
mask2 = bwareafilt(logical(mask2),[140 size(image,1)*size(image,2)]);
mask2 = imclose(mask2,strel('disk', round(0.0667*D)));
mask2 = imdilate(mask2,strel('disk',round(0.0167*D)));
mask2 = imfill(mask2,"holes");

brainMask = mask2;

outputImage = mask;
outputImage(mask2==1)=0;

outputImage = bwareafilt(outputImage,[250 size(image,1)*size(image,2)]);



end