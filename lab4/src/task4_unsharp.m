% Task 4 – Sharpening via Unsharp Masking
% Image 1: ImgTestSharp.tif
% Image 2: America.tif smoothed with Gaussian sigma=1.8 (from Task 3)
% Alpha values: 0.3, 0.7, 1.2

pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
alphas = [0.3, 0.7, 1.2];

function process_unsharp(img_input, tag, alphas, out_dir)
    if size(img_input, 3) == 3
        img_base = img_input;
    else
        img_base = img_input;
    end
    img_base = im2uint8(img_base);

    sigma_blur = 1.5;
    h_blur = fspecial('gaussian', [9 9], sigma_blur);

    if size(img_base, 3) == 3
        img_blurred = cat(3, imfilter(img_base(:,:,1), h_blur, 'replicate'), ...
                             imfilter(img_base(:,:,2), h_blur, 'replicate'), ...
                             imfilter(img_base(:,:,3), h_blur, 'replicate'));
    else
        img_blurred = imfilter(img_base, h_blur, 'replicate');
    end

    img_sharp = cell(1, length(alphas));
    for i = 1:length(alphas)
        alpha = alphas(i);
        mask = double(img_base) - double(img_blurred);
        sharpened = double(img_base) + alpha * mask;
        sharpened = uint8(min(max(sharpened, 0), 255));
        img_sharp{i} = sharpened;
    end

    imwrite(img_base,     [out_dir 'task4_original_'   tag '.png']);
    imwrite(img_blurred,  [out_dir 'task4_blurred_'    tag '.png']);
    imwrite(img_sharp{1}, [out_dir 'task4_unsharp_a03_' tag '.png']);
    imwrite(img_sharp{2}, [out_dir 'task4_unsharp_a07_' tag '.png']);
    imwrite(img_sharp{3}, [out_dir 'task4_unsharp_a12_' tag '.png']);

    fig = figure('visible', 'off', 'Position', [0 0 1200 400]);
    all_imgs   = {img_base, img_sharp{1}, img_sharp{2}, img_sharp{3}};
    all_titles = {'Original', 'alpha=0.3', 'alpha=0.7', 'alpha=1.2'};
    for i = 1:4
        subplot(1, 4, i);
        imshow(all_imgs{i});
        title(all_titles{i});
    end
    saveas(fig, [out_dir 'task4_comparison_' tag '.png']);
    close(fig);
end

% --- Image 1: ImgTestSharp.tif ---
img1 = imread([img_dir 'ImgTestSharp.tif']);
if size(img1, 3) == 3
    img1 = rgb2gray(img1);
end
process_unsharp(img1, 'ImgTestSharp', alphas, out_dir);

% --- Image 2: America.tif pre-smoothed with Gaussian sigma=1.8 (Task 3 result) ---
img2 = imread([img_dir 'America.tif']);
hg18 = fspecial('gaussian', [21 21], 1.8);
img2_smoothed = cat(3, imfilter(img2(:,:,1), hg18, 'replicate'), ...
                       imfilter(img2(:,:,2), hg18, 'replicate'), ...
                       imfilter(img2(:,:,3), hg18, 'replicate'));
process_unsharp(img2_smoothed, 'America', alphas, out_dir);
