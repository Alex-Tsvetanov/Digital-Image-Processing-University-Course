pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

img = imread([img_dir 'FingerprintNoise.tif']);
if size(img, 3) == 3; img = rgb2gray(img); end

imwrite(img, [out_dir 'task4_original.png']);

ws = [3, 7];

for i = 1:length(ws)
    W  = ws(i);
    SE = strel('square', W);

    img_open  = imopen(img, SE);
    img_close = imclose(img_open, SE);

    imwrite(img_open,  [out_dir 'task4_open_W'  num2str(W) '.png']);
    imwrite(img_close, [out_dir 'task4_close_W' num2str(W) '.png']);

    fig = figure('visible', 'off', 'Position', [0 0 1200 400]);
    subplot(1,3,1); imshow(img);       title('Оригинал');
    subplot(1,3,2); imshow(img_open);  title(['Opening W=' num2str(W)]);
    subplot(1,3,3); imshow(img_close); title(['Closing W=' num2str(W)]);
    saveas(fig, [out_dir 'task4_comparison_W' num2str(W) '.png']);
    close(fig);
end

% Combined figure: all 5 panels
SE3 = strel('square', ws(1));
SE7 = strel('square', ws(2));
open3  = imopen(img, SE3);
close3 = imclose(open3, SE3);
open7  = imopen(img, SE7);
close7 = imclose(open7, SE7);

fig_all = figure('visible', 'off', 'Position', [0 0 2000 420]);
subplot(1,5,1); imshow(img);    title('Оригинал');
subplot(1,5,2); imshow(open3);  title(['Opening W=' num2str(ws(1))]);
subplot(1,5,3); imshow(close3); title(['Closing W=' num2str(ws(1))]);
subplot(1,5,4); imshow(open7);  title(['Opening W=' num2str(ws(2))]);
subplot(1,5,5); imshow(close7); title(['Closing W=' num2str(ws(2))]);
saveas(fig_all, [out_dir 'task4_comparison_all.png']);
close(fig_all);
