close all;

[files, path] = uigetfile('*.png', 'Select PNG Files', 'MultiSelect', 'on');
if ~iscell(files)
    if files == 0
        return
    end
    files = { files };
end

totalFiles = length(files);
hWaitFig = uifigure('Name', 'Processing Files', 'NumberTitle', 'off', 'HandleVisibility', 'off', 'CloseRequestFcn', @(src, event) delete(src));
hWaitBar = uiprogressdlg(hWaitFig, 'Title', 'Please wait', 'Message', 'Processing Files...');

% files = { "AX_1.png", "AX_2.png", "AX_3.png", "AX_4.png", "AX_5.png", "SAG_1.png", "SAG_2.png", "SAG_3.png", "SAG_4.png", "SAG_5.png", "COR_1.png", "COR_2.png", "COR_3.png", "COR_4.png", "COR_5.png" };
for i = 1:length(files)

    uiprogressdlg(hWaitFig, 'Value', (i-1) / totalFiles, 'Message', sprintf('Processing Files... (%d/%d)', i, totalFiles));

    filename = fullfile(path, files{i});
    image= im2double(imread(filename));

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

    % Update progress bar
    uiprogressdlg(hWaitFig, 'Value', i / totalFiles, 'Message', sprintf('Processing Files... (%d/%d)', i, totalFiles));

end

% Close the progress bar
delete(hWaitFig);