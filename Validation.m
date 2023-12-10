function [DSbackground,sensitivity,specificity] = Validation(groundTruth,segmentation, caseOfValidation)
%VALIDATION Summary of this function goes here
%   Detailed explanation goes here
DSbackground = dice(groundTruth,segmentation);

TP = sum(groundTruth(:) & segmentation(:));
TN = sum(~groundTruth(:) & ~segmentation(:));
FP = sum(~groundTruth(:) & segmentation(:));
FN = sum(groundTruth(:) & ~segmentation(:));

sensitivity = TP / (TP + FN);  
specificity = TN / (TN + FP);  

fprintf('Dice Score segmentation %d : %d \n',caseOfValidation,DSbackground);
fprintf('Sensitivity segmentation %d : %d \n', caseOfValidation,sensitivity);
fprintf('Specificity segmentation %d : %d \n', caseOfValidation, specificity);
end

