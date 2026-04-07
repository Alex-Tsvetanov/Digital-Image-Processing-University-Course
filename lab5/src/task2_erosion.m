pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

img = imread([img_dir 'Erosion.tif']);
if size(img, 3) == 3; img = rgb2gray(img); end

imwrite(img, [out_dir 'task2_original.png']);

params = [2, 4, 6, 8, 10];
types  = {'diamond', 'disk', 'square'};

for t = 1:length(types)
    stype = types{t};

    fig = figure('visible', 'off', 'Position', [0 0 1800 400]);
    subplot(1, 6, 1); imshow(img); title('Оригинал');

    for p = 1:length(params)
        param  = params(p);
        if strcmp(stype, 'disk')
            SE = strel(stype, param, 0);
        else
            SE = strel(stype, param);
        end
        img_er = imerode(img, SE);

        imwrite(img_er, [out_dir 'task2_erode_' stype '_' num2str(param) '.png']);

        subplot(1, 6, p+1);
        imshow(img_er);
        title([stype ' ' num2str(param)]);
    end

    saveas(fig, [out_dir 'task2_comparison_' stype '.png']);
    close(fig);
end
