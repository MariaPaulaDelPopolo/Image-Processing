function [DSbackground, sensitivity, specificity, SD_DS, SD_sensitivity, SD_specificity] = Validation(groundTruth, segmentation, caseOfValidation)
    % VALIDATION Summary of this function goes here
    %   Detailed explanation goes here
    
    DSbackground = dice(groundTruth, segmentation);
    
    TP = sum(groundTruth(:) & segmentation(:));
    TN = sum(~groundTruth(:) & ~segmentation(:));
    FP = sum(~groundTruth(:) & segmentation(:));
    FN = sum(groundTruth(:) & ~segmentation(:));
    
    % Arrays for storing individual Dice Score, Sensitivity, Specificity values
    DS_values = zeros(1, caseOfValidation);
    sensitivity_values = zeros(1, caseOfValidation);
    specificity_values = zeros(1, caseOfValidation);
    
    % Compute values for each case
    for i = 1:caseOfValidation
        DS_values(i) = dice(groundTruth, segmentation);
        
        TP_i = sum(groundTruth(:) & segmentation(:));
        TN_i = sum(~groundTruth(:) & ~segmentation(:));
        FP_i = sum(~groundTruth(:) & segmentation(:));
        FN_i = sum(groundTruth(:) & ~segmentation(:));
        
        sensitivity_values(i) = TP_i / (TP_i + FN_i);
        specificity_values(i) = TN_i / (TN_i + FP_i);
    end
    
    sensitivity = mean(sensitivity_values);
    specificity = mean(specificity_values);

    SD_DS = std(DS_values);
    SD_sensitivity = std(sensitivity_values);
    SD_specificity = std(specificity_values);
    
    fprintf('Dice Score segmentation %d : %.4f (SD: %.4f)\n', caseOfValidation, DSbackground, SD_DS);
    fprintf('Sensitivity segmentation %d : %.4f (SD: %.4f)\n', caseOfValidation, sensitivity, SD_sensitivity);
    fprintf('Specificity segmentation %d : %.4f (SD: %.4f)\n', caseOfValidation, specificity, SD_specificity);
end