function [outputImage] = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped)
% GREYMATTERSEGMENTATION - Segment grey matter in a T1-weighted image.
%
%   Input:
%   - whmSegIm: Binary mask of segmented white matter.
%   - csfSegIm: Binary mask of segmented cerebrospinal fluid (CSF).
%   - skullStripped: Binary mask of skull-stripped image.
%
%   Output:
%   - outputImage: Binary mask representing the segmented grey matter.
%
%   Description:
%   This function segments grey matter in a T1-weighted image by subtracting
%   the combined masks of white matter and CSF from the skull-stripped image.
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

% grey matter = brain - (csf + whitematter)
tempImage = csfSegIm + whmSegIm;
outputImage = (skullStripped - tempImage);

end
