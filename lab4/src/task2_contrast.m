% Task 2 – Dynamic Range Expansion: imadjust and gamma correction
% Uses: Img21.tif, Img24.tif

pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
images = {'Img21', 'Img24'};
gammas = [0.6, 1.0, 1.6];

for k = 1:length(images)
    name = images{k};
    img = imread([img_dir name '.tif']);

    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end
    img_gray = im2uint8(img_gray);

    % imadjust – linear contrast stretch
    img_adj = imadjust(img_gray);

    % Gamma correction results
    img_gamma = cell(1, length(gammas));
    for g = 1:length(gammas)
        gamma = gammas(g);
        img_norm = double(img_gray) / 255;
        img_corrected = img_norm .^ gamma;
        img_gamma{g} = im2uint8(img_corrected);
    end

    % Save individual images
    imwrite(img_gray,   [out_dir 'task2_original_'  name '.png']);
    imwrite(img_adj,    [out_dir 'task2_imadjust_'  name '.png']);
    imwrite(img_gamma{1}, [out_dir 'task2_gamma06_' name '.png']);
    imwrite(img_gamma{2}, [out_dir 'task2_gamma10_' name '.png']);
    imwrite(img_gamma{3}, [out_dir 'task2_gamma16_' name '.png']);

    % Comparison subplot: original + imadjust + gamma 0.6, 1.0, 1.6
    fig = figure('visible', 'off', 'Position', [0 0 1400 400]);
    titles = {[name ' оригинал'], 'imadjust', '\gamma=0.6', '\gamma=1.0', '\gamma=1.6'};
    imgs   = {img_gray, img_adj, img_gamma{1}, img_gamma{2}, img_gamma{3}};
    for i = 1:5
        subplot(1, 5, i);
        imshow(imgs{i});
        title(titles{i});
    end
    saveas(fig, [out_dir 'task2_comparison_' name '.png']);
    close(fig);

    % Histogram comparison: original + imadjust + gammas
    fig2 = figure('visible', 'off', 'Position', [0 0 1400 400]);
    all_imgs = [imgs];
    hist_titles = titles;
    for i = 1:5
        subplot(1, 5, i);
        centers = 0:255;
        counts = histc(double(all_imgs{i}(:)), centers);
        bar(centers, counts, 1, 'FaceColor', [0.2 0.5 0.8], 'EdgeColor', 'none');
        xlim([0 255]);
        title(hist_titles{i});
        xlabel('Интензитет');
    end
    saveas(fig2, [out_dir 'task2_histograms_' name '.png']);
    close(fig2);
end
