% Task 1 – Histogram Analysis
% Images: Img17.tif, Img18.tif, Img19.tif, Img21.tif, Img24.tif

pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
images = {'Img17', 'Img18', 'Img19', 'Img21', 'Img24'};

num_bins = 256;
bin_range = [0, 255];

stats = zeros(length(images), 2); % [mean, std] per image

for k = 1:length(images)
    name = images{k};
    img = imread([img_dir name '.tif']);

    % Convert to grayscale if needed
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end

    img_gray = im2uint8(img_gray);

    % Compute stats
    stats(k, 1) = mean(double(img_gray(:)));
    stats(k, 2) = std(double(img_gray(:)));

    % Plot: original + histogram
    fig = figure('visible', 'off', 'Position', [0 0 900 400]);
    subplot(1, 2, 1);
    imshow(img_gray);
    title([name ' – оригинал'], 'Interpreter', 'none');

    subplot(1, 2, 2);
    centers = 0:255;
    counts = histc(double(img_gray(:)), centers);
    bar(centers, counts, 1, 'FaceColor', [0.3 0.3 0.8], 'EdgeColor', 'none');
    xlim(bin_range);
    xlabel('Интензитет');
    ylabel('Брой пиксели');
    title([name ' – хистограма'], 'Interpreter', 'none');

    saveas(fig, [out_dir 'task1_subplot_' name '.png']);
    close(fig);
end

% Print stats table
fprintf('\n%-10s %-12s %-12s %-12s %-12s\n', 'Изображение', 'Яркост(mean)', 'Контраст(std)', 'Класиф. Яркост', 'Класиф. Контраст');
for k = 1:length(images)
    m = stats(k,1);
    s = stats(k,2);

    if m < 85
        bright_class = 'Тъмно';
    elseif m < 170
        bright_class = 'Средно';
    else
        bright_class = 'Светло';
    end

    if s < 40
        contrast_class = 'Нисък';
    elseif s < 70
        contrast_class = 'Среден';
    else
        contrast_class = 'Висок';
    end

    fprintf('%-10s %-12.2f %-12.2f %-12s %-12s\n', images{k}, m, s, bright_class, contrast_class);
end
