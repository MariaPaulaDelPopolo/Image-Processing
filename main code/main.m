% Loading the image
fig_or = figure(1);
set(fig_or, 'Name' , 'Original Image');
set(fig_or, 'Position', get(0, 'Screensize'));

fig_bg = figure(2);
set(fig_bg, 'Name' , 'Background Segmentation');
set(fig_bg, 'Position', get(0, 'Screensize'));

fig_sk = figure(3);
set(fig_sk, 'Name' , 'Skull Segmentation');
set(fig_sk, 'Position', get(0, 'Screensize'));

fig_csf = figure(4);
set(fig_csf, 'Name' , 'CSF Segmentation');
set(fig_csf, 'Position', get(0, 'Screensize'));

fig_wm = figure(5);
set(fig_wm, 'Name' , 'White matter Segmentation');
set(fig_wm, 'Position', get(0, 'Screensize'));

fig_gm = figure(6);
set(fig_gm, 'Name' , 'Grey matter Segmentation');
set(fig_gm, 'Position', get(0, 'Screensize'));

mypath = "C:\Users\ehulst\surfdrive - Hulst, E. van (Ellen)@surfdrive.surf.nl\Overig\Courses\G2 Image processing\Assignment\AssignmentTrainingImages\"
files = { "AX_1", "AX_2", "AX_3", "AX_4", "AX_5", "SAG_1", "SAG_2", "SAG_3", "SAG_4", "SAG_5", "COR_1", "COR_2", "COR_3", "COR_4", "COR_5" };
for i = 1:length(files)
    filename = files{i};
    extension = ".png";
    image= im2double(imread(mypath + filename + extension));
       
    [segmentations] = SegmentationT1wImage(image);
    
    bgrSegIm = segmentations(:,:,1);
    skuSegIm = segmentations(:,:,2);
    csfSegIm = segmentations(:,:,3);
    whmSegIm = segmentations(:,:,4);
    grmSegIm = segmentations(:,:,5);

    % imwrite(bgrSegIm, "Output Images\" + filename + "_backgroundSegmentation" + extension);
    % imwrite(skuSegIm, "Output Images\" + filename + "_SkullSegmentation" + extension);
    % imwrite(csfSegIm, "Output Images\" + filename + "_CSF" + extension);
    % imwrite(whmSegIm, "Output Images\" + filename + "_WhiteMatterSegmentation" + extension);
    % imwrite(grmSegIm, "Output Images\" + filename + "_GreyMatterSegmentation" + extension);

    figure(fig_or);
    subplot(3, 5, i);
    imshow(image);
    title(filename);
    
    figure(fig_bg);
    subplot(3, 5, i);
    imshow(segmentations(:,:,1));% .* image);
    title(filename);

    figure(fig_sk);
    subplot(3, 5, i);
    imshow(segmentations(:,:,2));% .* image);
    title(filename);

    figure(fig_csf);
    subplot(3, 5, i);
    imshow(segmentations(:,:,3));% .* image);
    title(filename);

    figure(fig_wm);
    subplot(3, 5, i);
    imshow(segmentations(:,:,4));% .* image);
    title(filename);

    figure(fig_gm);
    subplot(3, 5, i);
    imshow(segmentations(:,:,5));% .* image);
    title(filename);
    
end