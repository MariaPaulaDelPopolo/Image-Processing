function output_segmentations = SegmentationT1wImage(image)

% Get the size of the input image
[image_height, image_width] = size(image);
num_classes = 5;

% Create the 3D array with the specified dimensions
output_segmentations = zeros(image_height, image_width, num_classes);

%% Background segmentation
bgrSegIm = BackgroundSegmentation(image);
output_segmentations(:, :, 1) = bgrSegIm;
% imwrite(bgrSegIm, "Output Images\" + filename + "_backgroundSegmentation" + extension);

%% Skull stripping
skullStripped = SkullStripFilter(image);
% imshow(imcomplement(skullStripped) .* image);

%% Skull segmentation
skuSegIm = SkullSegmentation(skullStripped, bgrSegIm);
output_segmentations(:, :, 2) = skuSegIm;
% imwrite(skuSegIm, "Output Images\" + filename + "_SkullSegmentation" + extension);
 
%% CSF segmentation
csfSegIm = CSFSegmentation(image, skullStripped);
output_segmentations(:, :, 3) = csfSegIm;
% imwrite(csfSegIm, "Output Images\" + filename + "_CSFSegmentation" + extension);

%% White matter segmentation
whmSegIm = WhiteMatterSegmentation(image, csfSegIm, skullStripped);
output_segmentations(:, :, 4) = whmSegIm;
% imwrite(whmSegIm, "Output Images\" + filename + "_WhiteMatterSegmentation" + extension);

%% Grey matter segmentation
grmSegIm = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped);
output_segmentations(:, :, 5) = grmSegIm;
% imwrite(grmSegIm, "Output Images\" + filename + "_GreyMatterSegmentation" + extension);

end

