close all;

files = { "AX_1", "AX_2", "AX_3", "AX_4", "AX_5", "SAG_1", "SAG_2", "SAG_3", "SAG_4", "SAG_5", "COR_1", "COR_2", "COR_3", "COR_4", "COR_5" };
% files = {"TEST_AX_2", "TEST_SAG_1", "TEST_SAG_2", "TEST_COR_1", "TEST_COR_2" };
for i = 1:length(files)
    filename = files{i};
    extension = ".png";
    image= im2double(imread("Input Images/" + filename + extension));

    if size(image, 3) > 1
        image = rgb2gray(image);
    end
    
    [segmentations] = SegmentationT1wImage(image);
    
    bgrSegIm = segmentations(:,:,1);
    skuSegIm = segmentations(:,:,2);
    csfSegIm = segmentations(:,:,3);
    whmSegIm = segmentations(:,:,4);
    grmSegIm = segmentations(:,:,5);

    fig = figure;
    set(fig, 'Name' , filename);
    set(fig, 'Position', get(0, 'Screensize'));

    % filename
    % bgrMin = min(bgrSegIm(:))
    % skuMin = min(skuSegIm(:))
    % csfMin = min(csfSegIm(:))
    % whmMin = min(whmSegIm(:))
    % grmMin = min(grmSegIm(:))

    overlap = bgrSegIm + skuSegIm + csfSegIm + whmSegIm + grmSegIm;
    overlap = label2rgb(overlap);

    subplot(2, 6, 1);
    imshow(overlap);
    title('Overlap');

    subplot(2, 6, 2);
    imshow(bgrSegIm);
    title('Background mask');

    subplot(2, 6, 3);
    imshow(skuSegIm);
    title('Skull mask');

    subplot(2, 6, 4);
    imshow(csfSegIm);
    title('CSF mask');

    subplot(2, 6, 5);
    imshow(whmSegIm);
    title('White matter mask');

    subplot(2, 6, 6);
    imshow(grmSegIm);
    title('Grey matter mask');

    subplot(2, 6, 7);
    imshow(image);
    title('Original');

    subplot(2, 6, 8);
    imshow(normalize(bgrSegIm .* image));
    title('Background (normalized)');

    subplot(2, 6, 9);
    imshow(skuSegIm .* image);
    title('Skull');

    subplot(2, 6, 10);
    imshow(normalize(csfSegIm .* image));
    title('CSF (normalized)');

    subplot(2, 6, 11);
    imshow(whmSegIm .* image);
    title('White matter');

    subplot(2, 6, 12);
    imshow(grmSegIm .* image);
    title('Grey matter');

end