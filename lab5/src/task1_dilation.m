pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

% Read images
img1 = imread([img_dir 'Dilation.tif']);
img2 = imread([img_dir 'ToiletOpen.tif']);

if size(img1, 3) == 3; img1 = rgb2gray(img1); end
if size(img2, 3) == 3; img2 = rgb2gray(img2); end

% Original SE: 3x3 square (all ones)
SE_orig = strel('square', 3);

% X-type SE: only main and secondary diagonals
SE_x_mat = logical([1 0 1; 0 1 0; 1 0 1]);
SE_x = strel('arbitrary', SE_x_mat);

% Apply dilation
img1_dil_orig = imdilate(img1, SE_orig);
img1_dil_x    = imdilate(img1, SE_x);
img2_dil_orig = imdilate(img2, SE_orig);
img2_dil_x    = imdilate(img2, SE_x);

% Save individual results
imwrite(img1,           [out_dir 'task1_orig_Dilation.png']);
imwrite(img1_dil_orig,  [out_dir 'task1_dil_orig_Dilation.png']);
imwrite(img1_dil_x,     [out_dir 'task1_dil_x_Dilation.png']);
imwrite(img2,           [out_dir 'task1_orig_ToiletOpen.png']);
imwrite(img2_dil_orig,  [out_dir 'task1_dil_orig_ToiletOpen.png']);
imwrite(img2_dil_x,     [out_dir 'task1_dil_x_ToiletOpen.png']);

% Comparison figure for Dilation.tif
fig1 = figure('visible', 'off', 'Position', [0 0 1200 400]);
subplot(1,3,1); imshow(img1);          title('Оригинал');
subplot(1,3,2); imshow(img1_dil_orig); title('Дилатация – SE 3x3');
subplot(1,3,3); imshow(img1_dil_x);   title('Дилатация – SE тип X');
saveas(fig1, [out_dir 'task1_comparison_Dilation.png']); close(fig1);

% Comparison figure for ToiletOpen.tif
fig2 = figure('visible', 'off', 'Position', [0 0 1200 400]);
subplot(1,3,1); imshow(img2);          title('Оригинал');
subplot(1,3,2); imshow(img2_dil_orig); title('Дилатация – SE 3x3');
subplot(1,3,3); imshow(img2_dil_x);   title('Дилатация – SE тип X');
saveas(fig2, [out_dir 'task1_comparison_ToiletOpen.png']); close(fig2);

% SE visualization
SE_orig_mat = ones(3, 3);
fig3 = figure('visible', 'off', 'Position', [0 0 600 300]);
subplot(1,2,1);
imagesc(SE_orig_mat); colormap(gray); caxis([0 1]);
axis off equal; title('SE оригинален (3x3)');
subplot(1,2,2);
imagesc(double(SE_x_mat)); colormap(gray); caxis([0 1]);
axis off equal; title('SE тип X');
saveas(fig3, [out_dir 'task1_se_visualization.png']); close(fig3);
