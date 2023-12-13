function SD(DS_values,sensitivity_values,specificity_values,i,j)
        sensitivity = mean(sensitivity_values, 'omitnan');
        specificity = mean(specificity_values, 'omitnan');
        DSbackground = mean(DS_values, 'omitnan');
    
        SD_DS = std(DS_values, 'omitnan');
        SD_sensitivity = std(sensitivity_values, 'omitnan');
        SD_specificity = std(specificity_values, 'omitnan');
        
        fprintf('Dice Score file %d segmentation %d : %.4f (SD: %.4f)\n', i, j, DSbackground, SD_DS);
        fprintf('Sensitivity file %d segmentation %d : %.4f (SD: %.4f)\n', i, j, sensitivity, SD_sensitivity);
        fprintf('Specificity file %d segmentation %d : %.4f (SD: %.4f)\n', i, j, specificity, SD_specificity);
        % Arrays for storing individual Dice Score, Sensitivity, Specificity values

end

