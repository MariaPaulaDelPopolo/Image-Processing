function [outputImage] = SkullStripFilter(skuSegIm, bgrSegIm)
% SKULLSTRIPFILTER - Generate a brain-only image by combining skull and background segmentations.
%
%   Input:
%   - skuSegIm: Binary mask of the skull segmentation.
%   - bgrSegIm: Binary mask of the background segmentation.
%
%   Output:
%   - outputImage: Binary mask representing the brain-only image.
%
%   Description:
%   This function generates a brain-only image by combining the closed
%   skull segmentation with the background segmentation. It utilizes
%   morphological operations for refinement and complementation to obtain
%   the final brain-only mask.
%
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

D = Diagonal(skuSegIm); % Diagonal of the image

% Combine closed skull segmentation whith backgroundsegmentation
skuSegIm = imclose(skuSegIm, strel('disk', round(0.0500*D)));
maskImage = (skuSegIm + bgrSegIm) > 0.5;
maskImage = imclose(maskImage, strel('disk', round(0.0667*D)));

% complement is brain only image
outputImage = imcomplement(maskImage);

end