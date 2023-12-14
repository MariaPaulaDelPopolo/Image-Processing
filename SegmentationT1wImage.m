function [output_segmentations] = SegmentationT1wImage(image)
% SEGMENTATIONT1WIMAGE - Perform multi-class segmentation on a T1-weighted image.
%
%   output_segmentations = SegmentationT1wImage(image)
%
%   Input:
%   - image: T1-weighted image to be segmented.
%
%   Output:
%   - output_segmentations: 3D array containing segmented regions.
%                           Dimensions: [image_height, image_width, num_classes]
%
%   Classes:
%   1. Background
%   2. Skull
%   3. CSF (Cerebrospinal Fluid)
%   4. White Matter
%   5. Grey Matter
%
%   Description:
%   This function takes a T1-weighted image as input and performs a series
%   of segmentation steps to identify different regions within the image.
%
%   Steps:
%   1. Background Segmentation: Identify background regions.
%   2. Skull Segmentation: Isolate the skull region.
%   3. Skull Stripping: Mask the brain only, containing CSF, White matter and Grey Matter.
%   4. CSF Segmentation: Identify CSF regions.
%   5. White Matter Segmentation: Indentify white matter regions.
%   6. Grey Matter Segmentation: Indentify grey matter regions.
%
%   See also: BackgroundSegmentation, SkullSegmentation, SkullStripFilter,
%             CSFSegmentation, WhiteMatterSegmentation, GreyMatterSegmentation.
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023


% Making sure the image is double greyscale
if size(image, 3) > 1
   image = rgb2gray(image);
end

image= im2double(image); 

% Get the size of the input image
[image_height, image_width] = size(image);
num_classes = 5;
output_segmentations = zeros(image_height, image_width, num_classes);

%% Background segmentation
bgrSegIm = BackgroundSegmentation(image);
output_segmentations(:, :, 1) = bgrSegIm;

%% Skull segmentation
skuSegIm = SkullSegmentation(image, bgrSegIm);
output_segmentations(:, :, 2) = skuSegIm;

%% Skull stripping
skullStripped = SkullStripFilter(skuSegIm, bgrSegIm);
% imshow(imcomplement(skullStripped) .* image);

%% CSF segmentation
csfSegIm = CSFSegmentation(image, skullStripped);
output_segmentations(:, :, 3) = csfSegIm;

%% White matter segmentation
whmSegIm = WhiteMatterSegmentation(image, csfSegIm, skullStripped);
output_segmentations(:, :, 4) = whmSegIm;

%% Grey matter segmentation
grmSegIm = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped);
output_segmentations(:, :, 5) = grmSegIm;

end