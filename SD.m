function SD()
    files = { "AX_", "SAG_", "COR_"}; %"AX_1", "AX_2", "AX_3", "AX_4", "AX_5", "SAG_1", "SAG_2", "SAG_3", "SAG_4", "SAG_5", "COR_1", "COR_2", "COR_3", "COR_4", "COR_5" };

    for i = 1:length(files)
    filename = files{i};
    extension = ".png";
        for j = 1:5
        DS_values = [];
        sensitivity_values = [];
        specificity_values = [];

            for k = 1:5
    
                [DSbackground,sensitivity,specificity] = Validation(im2double(imread("Output Images\" + filename + k + "_SEG" + j + extension)), im2double(imread("TrainingImagesAndSegmentations\AssignmentTrainingSegmentations\" + filename + k + "_SEG" + j + extension)), j);
                DS_values(end+1) = DSbackground;
                sensitivity_values(end+1) = sensitivity;
                specificity_values(end+1) = specificity;
            end

        sensitivity = mean(sensitivity_values, 'omitnan');
        specificity = mean(specificity_values, 'omitnan');
        DSbackground = mean(DS_values, 'omitnan');
    
        SD_DS = std(DS_values, 'omitnan');
        SD_sensitivity = std(sensitivity_values, 'omitnan');
        SD_specificity = std(specificity_values, 'omitnan');

        fprintf('Dice Score file %s segmentation %d : %.4f (SD: %.4f)\n', filename, j, DSbackground, SD_DS);
        fprintf('Sensitivity file %s segmentation %d : %.4f (SD: %.4f)\n', filename, j, sensitivity, SD_sensitivity);
        fprintf('Specificity file %s segmentation %d : %.4f (SD: %.4f)\n', filename, j, specificity, SD_specificity);
        end    
    end
end

        % Arrays for storing individual Dice Score, Sensitivity, Specificity values


