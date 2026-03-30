% Task 3 – Smoothing Spatial Filters
% Images: America.tif, SantaMaria.tif
% Filters: Mean (5x5, 11x11), Gaussian (sigma=0.8, sigma=1.8), Median (3x3, 7x7)

pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
images = {'America', 'SantaMaria'};

for k = 1:length(images)
    name = images{k};
    img = imread([img_dir name '.tif']);

    % Work per channel if color, then recombine
    is_color = (size(img, 3) == 3);

    function result = apply_filter_img(img, filt_func)
        if size(img, 3) == 3
            result = cat(3, filt_func(img(:,:,1)), filt_func(img(:,:,2)), filt_func(img(:,:,3)));
        else
            result = filt_func(img);
        end
    end

    % Mean filters
    h5   = fspecial('average', [5 5]);
    h11  = fspecial('average', [11 11]);
    img_mean5  = apply_filter_img(img, @(x) imfilter(x, h5,  'replicate'));
    img_mean11 = apply_filter_img(img, @(x) imfilter(x, h11, 'replicate'));

    % Gaussian filters
    hg08 = fspecial('gaussian', [15 15], 0.8);
    hg18 = fspecial('gaussian', [21 21], 1.8);
    img_gauss08 = apply_filter_img(img, @(x) imfilter(x, hg08, 'replicate'));
    img_gauss18 = apply_filter_img(img, @(x) imfilter(x, hg18, 'replicate'));

    % Median filters
    img_med3 = apply_filter_img(img, @(x) medfilt2(x, [3 3]));
    img_med7 = apply_filter_img(img, @(x) medfilt2(x, [7 7]));

    % Save individual results
    imwrite(img,        [out_dir 'task3_original_'   name '.png']);
    imwrite(img_mean5,  [out_dir 'task3_mean5_'      name '.png']);
    imwrite(img_mean11, [out_dir 'task3_mean11_'     name '.png']);
    imwrite(img_gauss08,[out_dir 'task3_gauss08_'    name '.png']);
    imwrite(img_gauss18,[out_dir 'task3_gauss18_'    name '.png']);
    imwrite(img_med3,   [out_dir 'task3_median3_'    name '.png']);
    imwrite(img_med7,   [out_dir 'task3_median7_'    name '.png']);

    % Comparison figure: original + all 6 filtered
    fig = figure('visible', 'off', 'Position', [0 0 1800 700]);
    all_imgs   = {img, img_mean5, img_mean11, img_gauss08, img_gauss18, img_med3, img_med7};
    all_titles = {[name ' оригинал'], 'Mean 5×5', 'Mean 11×11', ...
                  'Gauss \sigma=0.8', 'Gauss \sigma=1.8', 'Median 3×3', 'Median 7×7'};
    for i = 1:7
        subplot(2, 4, i);
        imshow(all_imgs{i});
        title(all_titles{i});
    end
    saveas(fig, [out_dir 'task3_comparison_' name '.png']);
    close(fig);
end
