pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

images = {'Satellite1', 'Satellite2'};

% HSV thresholds for water/reservoir segmentation (H and S in [0,1])
h_min = [0.50, 0.48];
h_max = [0.72, 0.75];
s_min = [0.15, 0.12];
s_max = [1.00, 1.00];

for k = 1:length(images)
    name    = images{k};
    img_rgb = imread([img_dir name '.tif']);

    % Convert to HSV (values in [0,1])
    img_hsv = rgb2hsv(img_rgb);
    H = img_hsv(:,:,1);
    S = img_hsv(:,:,2);

    % Threshold mask for water (by H and S)
    mask = (H >= h_min(k)) & (H <= h_max(k)) & ...
           (S >= s_min(k)) & (S <= s_max(k));

    % Morphological cleaning: open to remove noise, close to fill holes
    SE = strel('disk', 3, 0);
    mask_morph = imclose(imopen(mask, SE), SE);

    % Contour extraction via XOR
    contour_xor = xor(mask, mask_morph);

    % Save individual images
    imwrite(img_rgb,                      [out_dir 'task3_rgb_'        name '.png']);
    imwrite(im2uint8(H),                  [out_dir 'task3_H_'          name '.png']);
    imwrite(im2uint8(S),                  [out_dir 'task3_S_'          name '.png']);
    imwrite(im2uint8(double(mask)),       [out_dir 'task3_mask_'       name '.png']);
    imwrite(im2uint8(double(mask_morph)), [out_dir 'task3_mask_morph_' name '.png']);
    imwrite(im2uint8(double(contour_xor)),[out_dir 'task3_contour_'    name '.png']);

    % Composite comparison figure
    fig = figure('visible', 'off', 'Position', [0 0 1800 700]);
    subplot(2,3,1); imshow(img_rgb);    title('RGB оригинал');
    subplot(2,3,2); imshow(H);          title('Канал H');
    subplot(2,3,3); imshow(S);          title('Канал S');
    subplot(2,3,4); imshow(mask);       title('Маска (праг)');
    subplot(2,3,5); imshow(mask_morph); title('Маска (морфология)');
    subplot(2,3,6); imshow(contour_xor);title('Контури (XOR)');
    saveas(fig, [out_dir 'task3_comparison_' name '.png']);
    close(fig);
end
