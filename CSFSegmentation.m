function [outputImage] = CSFSegmentation(image, skullStripped)
% CSFSEGMENTATION - Segment cerebrospinal fluid (CSF) in a T1-weighted image.
%
%   Input:
%   - image: Normalised T1-weighted greyscale image.
%   - skullStripped: Binary brain-only mask.
%
%   Output:
%   - outputImage: Binary mask representing the segmented CSF.
%
%   Description:
%   This function segments cerebrospinal fluid (CSF) in a T1-weighted image
%   using a threshold determined by the crossing point of Gaussian curves
%   fitted to the histogram. It iteratively refines the threshold to ensure
%   a valid segmentation within the brain mask.
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023


maskedImage = image .* skullStripped;

% Choose threshold based on gaussian curves, keep trying till valid
% threshold is found
count = 0;
threshold = 0;
while (count < sum(maskedImage(:) > 1) * 0.1) || (threshold < 0.02)  
    threshold = CrossPointGauss(image(maskedImage > 0), 6, 0.2);
    count = sum((image(:) .* maskedImage(:)) < threshold);
end

% Threshold the masked image, remove everything not in the brain mask
csfSegIm = maskedImage < threshold;
csfSegIm = (csfSegIm - imcomplement(skullStripped)) > 0;

outputImage = csfSegIm;

end

