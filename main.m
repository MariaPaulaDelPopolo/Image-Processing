% Loading the image
files = { "AX_1", "AX_2", "AX_3", "AX_4", "AX_5", "SAG_1", "SAG_2", "SAG_3", "SAG_4", "SAG_5", "COR_1", "COR_2", "COR_3", "COR_4", "COR_5" };
for i = 1:length(files)
    filename = files{i};
    extension = ".png";
    image= im2double(imread("Input Images/" + filename + extension));
    % imshow(image);
    
    segmentations = SegmentationT1wImage(image);

    figure(1);
    subplot(3, 5, i);
    imshow(segmentations(:,:,5) .* image);
    title(filename);
    
end