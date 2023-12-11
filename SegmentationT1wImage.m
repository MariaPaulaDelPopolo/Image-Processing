function [output_segmentations] = SegmentationT1wImage(image)

% Get the size of the input image
[image_height, image_width] = size(image);
num_classes = 5;

% Create the 3D array with the specified dimensions
output_segmentations = zeros(image_height, image_width, num_classes);

%% Background segmentation
bgrSegIm = BackgroundSegmentation(image);
output_segmentations(:, :, 1) = bgrSegIm;

%% Skull segmentation
[brainMask, skuSegIm] = SkullSegmentation(image, bgrSegIm);
output_segmentations(:, :, 2) = skuSegIm;

%% Skull stripping
skullStripped = SkullStripFilter(skuSegIm, bgrSegIm);
% imshow(imcomplement(skullStripped) .* image);

% figure;
% subplot(1,3,1);
% imshow(skullStripped);
% subplot(1,3,2);
% imshow(skullStripped .* image);
% subplot(1,3,3);
% imshow(image);

%% CSF segmentation
csfSegIm = CSFSegmentation(image, brainMask);
output_segmentations(:, :, 3) = csfSegIm;

% White matter segmentation
whmSegIm = WhiteMatterSegmentation(image, csfSegIm, brainMask);
output_segmentations(:, :, 4) = whmSegIm;

%% Grey matter segmentation
grmSegIm = GreyMatterSegmentation(whmSegIm ,csfSegIm, brainMask);
output_segmentations(:, :, 5) = grmSegIm;

end