% Main script for Lab 2

% Load images
img04 = imread('Img04.tif');
img05 = imread('Img05.tif');
img08 = imread('Img08.tif');
img23a = imread('Img23a.bmp');
img23b = imread('Img23b.jpg');

% Operations with constant on img05
c = 50;
add_const = uint8(max(0, min(255, double(img05) + c)));
sub_const = uint8(max(0, min(255, double(img05) - c)));
mul_const = uint8(max(0, min(255, double(img05) * c)));
div_const = uint8(max(0, min(255, double(img05) / c)));

% Combined operations
combined1 = uint8(max(0, min(255, double(uint8(max(0, min(255, double(img05) + c)))) / 2)));
combined2 = uint8(max(0, min(255, double(uint8(max(0, min(255, double(img05) - c)))) * 1.5)));

% Operations between img23a and img23b
% Resize img23b to match img23a if necessary
if ~isequal(size(img23a), size(img23b))
    img23b_resized = imresize(img23b, [size(img23a, 1), size(img23a, 2)]);
else
    img23b_resized = img23b;
end

add_ab = uint8(max(0, min(255, double(img23a) + double(img23b_resized))));
sub_ab = uint8(max(0, min(255, double(img23a) - double(img23b_resized))));
mul_ab = uint8(max(0, min(255, double(img23a) .* double(img23b_resized))));
img2_copy = img23b_resized;
img2_copy(img2_copy == 0) = 1;
div_ab = uint8(max(0, min(255, double(img23a) ./ double(img2_copy))));
abs_diff_ab = uint8(max(0, min(255, abs(double(img23a) - double(img23b_resized)))));

% Compute MSE and PSNR
mse_ab = mean((double(img23a(:)) - double(img23b_resized(:))).^2);
if mse_ab == 0
    psnr_ab = inf;
else
    psnr_ab = 10 * log10(255^2 / mse_ab);
end

% Per channel MSE/PSNR
if size(img23a, 3) == 3
    mse_r = mean((double(img23a(:,:,1)(:)) - double(img23b_resized(:,:,1)(:))).^2);
    mse_g = mean((double(img23a(:,:,2)(:)) - double(img23b_resized(:,:,2)(:))).^2);
    mse_b = mean((double(img23a(:,:,3)(:)) - double(img23b_resized(:,:,3)(:))).^2);
    if mse_r == 0
        psnr_r = inf;
    else
        psnr_r = 10 * log10(255^2 / mse_r);
    end
    if mse_g == 0
        psnr_g = inf;
    else
        psnr_g = 10 * log10(255^2 / mse_g);
    end
    if mse_b == 0
        psnr_b = inf;
    else
        psnr_b = 10 * log10(255^2 / mse_b);
    end
    % Save grayscale and channels
    gray = rgb2gray(img23a);
    imwrite(gray, 'results/gray.png');
    imwrite(img23a(:,:,1), 'results/r_channel.png');
    imwrite(img23a(:,:,2), 'results/g_channel.png');
    imwrite(img23a(:,:,3), 'results/b_channel.png');
end

% Save images
imwrite(add_const, 'results/add_const.png');
imwrite(sub_const, 'results/sub_const.png');
imwrite(mul_const, 'results/mul_const.png');
imwrite(div_const, 'results/div_const.png');
imwrite(combined1, 'results/combined1.png');
imwrite(combined2, 'results/combined2.png');
imwrite(add_ab, 'results/add_ab.png');
imwrite(sub_ab, 'results/sub_ab.png');
imwrite(mul_ab, 'results/mul_ab.png');
imwrite(div_ab, 'results/div_ab.png');
imwrite(abs_diff_ab, 'results/abs_diff_ab.png');

% Print results
fprintf('MSE between img23a and img23b: %.2f\n', mse_ab);
fprintf('PSNR between img23a and img23b: %.2f dB\n', psnr_ab);
if exist('mse_r', 'var')
    fprintf('Per channel MSE: R=%.2f, G=%.2f, B=%.2f\n', mse_r, mse_g, mse_b);
    fprintf('Per channel PSNR: R=%.2f, G=%.2f, B=%.2f dB\n', psnr_r, psnr_g, psnr_b);
end