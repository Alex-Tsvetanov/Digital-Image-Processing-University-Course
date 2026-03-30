pkg load image;

images = {'checkerboard_test.png', 'siemens_star.png', 'kodim13.png', 'Img08.tif'};

for i = 1:length(images)
    img_name = images{i};
    [~, base_name, ~] = fileparts(img_name);
    
    I = imread(['../Lab03_Resources/', img_name]);
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    I = im2double(I);

    I_ds_A = ds_factor2_A(I);
    I_ds_B = ds_factor2_B(I);

    imwrite(I, ['../results/task1_original_', base_name, '.png']);
    imwrite(I_ds_A, ['../results/task1_A_', base_name, '.png']);
    imwrite(I_ds_B, ['../results/task1_B_', base_name, '.png']);

    [H, W] = size(I);
    startH = max(1, floor(H/2) - 50);
    startW = max(1, floor(W/2) - 50);
    r = startH:min(H, startH+100);
    c = startW:min(W, startW+100);

    imwrite(I(r,c), ['../results/task1_zoom_original_', base_name, '.png']);
    
    r_ds = floor(r/2); r_ds(r_ds < 1) = 1;
    c_ds = floor(c/2); c_ds(c_ds < 1) = 1;
    
    imwrite(I_ds_A(r_ds, c_ds), ['../results/task1_zoom_A_', base_name, '.png']);
    imwrite(I_ds_B(r_ds, c_ds), ['../results/task1_zoom_B_', base_name, '.png']);
end

% Task 2 & 3 for Img08.tif
I = imread('../Lab03_Resources/Img08.tif');
if ndims(I) == 3; I = rgb2gray(I); end
I = im2double(I);

I_ds_A = ds_factor2_A(I);
I_ds_B = ds_factor2_B(I);
h = fspecial('gaussian', [7 7], 1.0);
I_filt = imfilter(I, h, 'replicate', 'same');
I_ds_FA = ds_factor2_A(I_filt);
I_ds_FB = ds_factor2_B(I_filt);
I_r = imresize(I, 0.5, 'bicubic');

imwrite(I_ds_FA, '../results/task2_FA.png');
imwrite(I_ds_FB, '../results/task2_FB.png');
imwrite(I_r, '../results/task2_Ir.png');

r = 150:250; c = 150:250;
r_ds = floor(r/2); c_ds = floor(c/2);
imwrite(I_ds_FA(r_ds, c_ds), '../results/task2_zoom_FA.png');
imwrite(I_ds_FB(r_ds, c_ds), '../results/task2_zoom_FB.png');
imwrite(I_r(r_ds, c_ds), '../results/task2_zoom_Ir.png');

% Task 2 Metrics
rA_h = min(size(I_r,1), size(I_ds_A,1)); rA_w = min(size(I_r,2), size(I_ds_A,2));
mse_A  = calc_mse(I_r(1:rA_h, 1:rA_w), I_ds_A(1:rA_h, 1:rA_w));
rB_h = min(size(I_r,1), size(I_ds_B,1)); rB_w = min(size(I_r,2), size(I_ds_B,2));
mse_B  = calc_mse(I_r(1:rB_h, 1:rB_w), I_ds_B(1:rB_h, 1:rB_w));
rFA_h = min(size(I_r,1), size(I_ds_FA,1)); rFA_w = min(size(I_r,2), size(I_ds_FA,2));
mse_FA = calc_mse(I_r(1:rFA_h, 1:rFA_w), I_ds_FA(1:rFA_h, 1:rFA_w));
rFB_h = min(size(I_r,1), size(I_ds_FB,1)); rFB_w = min(size(I_r,2), size(I_ds_FB,2));
mse_FB = calc_mse(I_r(1:rFB_h, 1:rFB_w), I_ds_FB(1:rFB_h, 1:rFB_w));
psnr_A  = calc_psnr_custom(I_r(1:rA_h, 1:rA_w), I_ds_A(1:rA_h, 1:rA_w), 1);
psnr_B  = calc_psnr_custom(I_r(1:rB_h, 1:rB_w), I_ds_B(1:rB_h, 1:rB_w), 1);
psnr_FA = calc_psnr_custom(I_r(1:rFA_h, 1:rFA_w), I_ds_FA(1:rFA_h, 1:rFA_w), 1);
psnr_FB = calc_psnr_custom(I_r(1:rFB_h, 1:rFB_w), I_ds_FB(1:rFB_h, 1:rFB_w), 1);
fprintf('--- Task 2 Metrics ---\n');
fprintf('A: MSE=%f, PSNR=%f\n', mse_A, psnr_A);
fprintf('B: MSE=%f, PSNR=%f\n', mse_B, psnr_B);
fprintf('FA: MSE=%f, PSNR=%f\n', mse_FA, psnr_FA);
fprintf('FB: MSE=%f, PSNR=%f\n', mse_FB, psnr_FB);

% Task 3
I_us_A  = upsample_nn_x2(I_ds_A);
I_us_B  = upsample_nn_x2(I_ds_B);
I_us_FA = upsample_nn_x2(I_ds_FA);
I_us_FB = upsample_nn_x2(I_ds_FB);
rows_A = min(size(I,1), size(I_us_A,1)); cols_A = min(size(I,2), size(I_us_A,2));
rows_B = min(size(I,1), size(I_us_B,1)); cols_B = min(size(I,2), size(I_us_B,2));
rows_FA = min(size(I,1), size(I_us_FA,1)); cols_FA = min(size(I,2), size(I_us_FA,2));
rows_FB = min(size(I,1), size(I_us_FB,1)); cols_FB = min(size(I,2), size(I_us_FB,2));
I_us_A_c  = I_us_A(1:rows_A, 1:cols_A);
I_us_B_c  = I_us_B(1:rows_B, 1:cols_B);
I_us_FA_c = I_us_FA(1:rows_FA, 1:cols_FA);
I_us_FB_c = I_us_FB(1:rows_FB, 1:cols_FB);
imwrite(I_us_A_c, '../results/task3_A.png');
imwrite(I_us_B_c, '../results/task3_B.png');
imwrite(I_us_FA_c, '../results/task3_FA.png');
imwrite(I_us_FB_c, '../results/task3_FB.png');
imwrite(I_us_A_c(r,c), '../results/task3_zoom_A.png');
imwrite(I_us_B_c(r,c), '../results/task3_zoom_B.png');
imwrite(I_us_FA_c(r,c), '../results/task3_zoom_FA.png');
imwrite(I_us_FB_c(r,c), '../results/task3_zoom_FB.png');
mse_A3  = calc_mse(I(1:rows_A, 1:cols_A), I_us_A_c);
mse_B3  = calc_mse(I(1:rows_B, 1:cols_B), I_us_B_c);
mse_FA3 = calc_mse(I(1:rows_FA, 1:cols_FA), I_us_FA_c);
mse_FB3 = calc_mse(I(1:rows_FB, 1:cols_FB), I_us_FB_c);
psnr_A3  = calc_psnr_custom(I(1:rows_A, 1:cols_A), I_us_A_c, 1);
psnr_B3  = calc_psnr_custom(I(1:rows_B, 1:cols_B), I_us_B_c, 1);
psnr_FA3 = calc_psnr_custom(I(1:rows_FA, 1:cols_FA), I_us_FA_c, 1);
psnr_FB3 = calc_psnr_custom(I(1:rows_FB, 1:cols_FB), I_us_FB_c, 1);
fprintf('--- Task 3 Metrics ---\n');
fprintf('A->NN: MSE=%f, PSNR=%f\n', mse_A3, psnr_A3);
fprintf('B->NN: MSE=%f, PSNR=%f\n', mse_B3, psnr_B3);
fprintf('FA->NN: MSE=%f, PSNR=%f\n', mse_FA3, psnr_FA3);
fprintf('FB->NN: MSE=%f, PSNR=%f\n', mse_FB3, psnr_FB3);
