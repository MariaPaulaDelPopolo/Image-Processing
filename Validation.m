function [DSbackground, sensitivity, specificity] = Validation(groundTruth, segmentation, caseOfValidation)
    
    DSbackground = dice(groundTruth, segmentation);
    
    TP = sum(groundTruth(:) & segmentation(:));
    TN = sum(~groundTruth(:) & ~segmentation(:));
    FP = sum(~groundTruth(:) & segmentation(:));
    FN = sum(groundTruth(:) & ~segmentation(:));
    
    sensitivity = TP / max(1, (TP + FN));
    specificity = TN / max(1, (TN + FP));

end

