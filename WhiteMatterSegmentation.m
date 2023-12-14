function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)
% WHITEMATTERSEGMENTATION - Segment white matter in a T1-weighted image.
%
%   Input:
%   - image: T1-weighted image.
%   - csfSegIm: Binary mask of segmented cerebrospinal fluid (CSF).
%   - skullStripped: Binary mask of skull-stripped image.
%
%   Output:
%   - outputImage: Binary mask representing the segmented white matter.
%
%   Description:
%   This function segments white matter in a T1-weighted image by choosing
%   a threshold based on the crossing point of Gaussian curves fitted to the
%   histogram. It iteratively refines the threshold to ensure a valid segmentation
%   within the brain mask, excluding the CSF region.
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

mask = (skullStripped - csfSegIm);

% Choose threshold based on gaussian curves, keep trying till valid
% threshold is found
count = 0;
threshold = 0;
while (count < sum(mask(:) > 1) * 0.3) || (threshold < 0.2)
    threshold = CrossPointGauss(image(mask > 0), 2, 0.4);
    count = sum((image(:) .* mask(:)) < threshold);
end

% threshold largest component
whmSegIm = (image .* bwareafilt(logical(mask), 1)) > (threshold);
outputImage = whmSegIm;

end

