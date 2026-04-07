pkg load image;
clear; close all;

img_dir = '../images/';
out_dir = '../results/';
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

test_files = {'Digits_Test1', 'Digits_Test2', 'Digits_Test3'};

function img_bw = binarize(img_gray)
    img_d  = double(img_gray);
    img_n  = (img_d - min(img_d(:))) / (max(img_d(:)) - min(img_d(:)) + eps);
    thresh = graythresh(img_n);
    img_bw = img_n > thresh;
end

function components = get_digit_components(img_bw, min_area)
    % Digits are typically dark on white background – invert if needed
    dark_frac = mean(img_bw(:));
    if dark_frac > 0.5
        fg = ~img_bw;
    else
        fg = img_bw;
    end
    [labeled, n] = bwlabel(fg, 8);
    props = regionprops(labeled, 'BoundingBox', 'Image', 'Area', 'Centroid');
    areas = [props.Area];
    valid = find(areas >= min_area);
    if isempty(valid)
        components = struct([]);
        return;
    end
    bbs = vertcat(props(valid).BoundingBox);
    [~, ord] = sort(bbs(:,1));
    components = props(valid(ord));
end

function score = template_score(digit_patch, tmpl_patch, sz)
    d = imresize(double(digit_patch), sz);
    t = imresize(double(tmpl_patch),  sz);
    d = d > 0.5;
    t = t > 0.5;
    score = sum(sum(d == t)) / numel(d);
end

% ---------------------------------------------------------------
% Build templates from Digits_Test1 (assumed to contain '0' .. '9'
% sequentially left-to-right; adjust if your image differs)
% ---------------------------------------------------------------
ref_img  = imread([img_dir test_files{1} '.bmp']);
if size(ref_img, 3) == 3; ref_img = rgb2gray(ref_img); end
ref_bw   = binarize(ref_img);

SE_pre = strel('square', 2);
ref_clean = imclose(imopen(ref_bw, SE_pre), SE_pre);

ref_comps = get_digit_components(ref_clean, 30);

NORM_SZ = [32 32];

fprintf('Digits_Test1: detected %d components (used as templates)\n', length(ref_comps));

% ---------------------------------------------------------------
% Process each test image
% ---------------------------------------------------------------
for f = 1:length(test_files)
    name = test_files{f};
    img  = imread([img_dir name '.bmp']);
    if size(img, 3) == 3; img = rgb2gray(img); end

    img_bw    = binarize(img);
    img_clean = imclose(imopen(img_bw, SE_pre), SE_pre);

    comps = get_digit_components(img_clean, 30);

    % Match each component to closest template
    recognized = cell(1, length(comps));
    for c = 1:length(comps)
        patch = imresize(double(comps(c).Image), NORM_SZ);
        best_score = -1;
        best_idx   = -1;
        for r = 1:length(ref_comps)
            tmpl  = imresize(double(ref_comps(r).Image), NORM_SZ);
            sc    = template_score(patch, tmpl, NORM_SZ);
            if sc > best_score
                best_score = sc;
                best_idx   = r;
            end
        end
        recognized{c} = num2str(best_idx - 1);  % 0-indexed digit label
    end

    fprintf('%s: [%s]\n', name, strjoin(recognized, ' '));

    % Visualisation
    fig = figure('visible', 'off', 'Position', [0 0 900 350]);
    subplot(1,3,1); imshow(img);       title('Оригинал');
    subplot(1,3,2); imshow(img_clean); title('Предобработено');
    subplot(1,3,3);
    img_annot = repmat(im2uint8(~img_clean), [1 1 3]);
    red = reshape(uint8([255, 0, 0]), [1 1 3]);
    for c = 1:length(comps)
        bb = round(comps(c).BoundingBox);
        x1 = max(bb(1),1); y1 = max(bb(2),1);
        x2 = min(bb(1)+bb(3)-1, size(img_annot,2));
        y2 = min(bb(2)+bb(4)-1, size(img_annot,1));
        nr = y2-y1+1;  nc = x2-x1+1;
        img_annot(y1:y2, x1, :) = repmat(red, [nr, 1, 1]);
        img_annot(y1:y2, x2, :) = repmat(red, [nr, 1, 1]);
        img_annot(y1, x1:x2, :) = repmat(red, [1, nc, 1]);
        img_annot(y2, x1:x2, :) = repmat(red, [1, nc, 1]);
    end
    imshow(img_annot); title('Разпознаване');
    saveas(fig, [out_dir 'task_bonus_' name '.png']);
    close(fig);
end
