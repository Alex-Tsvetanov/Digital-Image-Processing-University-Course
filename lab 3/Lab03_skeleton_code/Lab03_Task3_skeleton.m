%% Task 3

pkg load image

% ---------------------------------------------------------
% 1. Load original image
% ---------------------------------------------------------
 I = imread('siemens_star.png');
% I = imread('checkerboard_test.png');
% I = imread('kodim13.png');
% I = imread('Img08.tif');

if ndims(I) == 3
    I = rgb2gray(I);
end

I = im2double(I);

% ---------------------------------------------------------
% 2. Generate reduced images
% ---------------------------------------------------------
I_ds_A = ds_factor2_A(I);
I_ds_B = ds_factor2_B(I);

h = fspecial('gaussian', [7 7], 1.0);
I_filt = imfilter(I, h, 'replicate', 'same');

I_ds_FA = ds_factor2_A(I_filt);
I_ds_FB = ds_factor2_B(I_filt);

% ---------------------------------------------------------
% 3. Upscale using your own nearest-neighbor function
% ---------------------------------------------------------
I_us_A  = upsample_nn_x2(I_ds_A);
I_us_B  = upsample_nn_x2(I_ds_B);
I_us_FA = upsample_nn_x2(I_ds_FA);
I_us_FB = upsample_nn_x2(I_ds_FB);

% ---------------------------------------------------------
% 4. Crop sizes if needed
% ---------------------------------------------------------
rows_A  = min(size(I,1), size(I_us_A,1));
cols_A  = min(size(I,2), size(I_us_A,2));

rows_B  = min(size(I,1), size(I_us_B,1));
cols_B  = min(size(I,2), size(I_us_B,2));

rows_FA = min(size(I,1), size(I_us_FA,1));
cols_FA = min(size(I,2), size(I_us_FA,2));

rows_FB = min(size(I,1), size(I_us_FB,1));
cols_FB = min(size(I,2), size(I_us_FB,2));

I_A_ref  = I(1:rows_A, 1:cols_A);
I_B_ref  = I(1:rows_B, 1:cols_B);
I_FA_ref = I(1:rows_FA, 1:cols_FA);
I_FB_ref = I(1:rows_FB, 1:cols_FB);

I_us_A_c  = I_us_A(1:rows_A, 1:cols_A);
I_us_B_c  = I_us_B(1:rows_B, 1:cols_B);
I_us_FA_c = I_us_FA(1:rows_FA, 1:cols_FA);
I_us_FB_c = I_us_FB(1:rows_FB, 1:cols_FB);

% ---------------------------------------------------------
% 5. Compute MSE
% ---------------------------------------------------------
% TODO
mse_A  = calc_mse(I_A_ref, I_us_A_c);
mse_B  = calc_mse(I_B_ref, I_us_B_c);
mse_FA = calc_mse(I_FA_ref, I_us_FA_c);
mse_FB = calc_mse(I_FB_ref, I_us_FB_c);

% ---------------------------------------------------------
% 6. Compute PSNR
% ---------------------------------------------------------
% TODO
% MAX = 1 because images are in double format

psnr_A  = calc_psnr_custom(I_A_ref, I_us_A_c, 1);
psnr_B  = calc_psnr_custom(I_B_ref, I_us_B_c, 1);
psnr_FA = calc_psnr_custom(I_FA_ref, I_us_FA_c, 1);
psnr_FB = calc_psnr_custom(I_FB_ref, I_us_FB_c, 1);

% ---------------------------------------------------------
% 7. Print results
% ---------------------------------------------------------
fprintf('Variant         MSE           PSNR [dB]\n');
fprintf('----------------------------------------\n');
fprintf('I_us_A   :   %0.8f    %0.4f\n', mse_A,  psnr_A);
fprintf('I_us_B   :   %0.8f    %0.4f\n', mse_B,  psnr_B);
fprintf('I_us_FA  :   %0.8f    %0.4f\n', mse_FA, psnr_FA);
fprintf('I_us_FB  :   %0.8f    %0.4f\n', mse_FB, psnr_FB);

% ---------------------------------------------------------
% 8. Visualization
% ---------------------------------------------------------
figure

subplot(2,3,1)
imshow(I,[])
title('Original')

subplot(2,3,2)
imshow(I_us_A_c,[])
title('I\_us\_A')

subplot(2,3,3)
imshow(I_us_B_c,[])
title('I\_us\_B')

subplot(2,3,5)
imshow(I_us_FA_c,[])
title('I\_us\_FA')

subplot(2,3,6)
imshow(I_us_FB_c,[])
title('I\_us\_FB')

% ---------------------------------------------------------
% 9. Zoom comparison
% ---------------------------------------------------------
% Select one region and compare the zoomed results
r = min(100:300, size(I,1));
c = min(100:300, size(I,2));

figure
subplot(2,3,1)
imshow(I(r,c),[])
title('Original Zoom')

subplot(2,3,2)
imshow(I_us_A_c(r,c),[])
title('I\_us\_A Zoom')

subplot(2,3,3)
imshow(I_us_B_c(r,c),[])
title('I\_us\_B Zoom')

subplot(2,3,5)
imshow(I_us_FA_c(r,c),[])
title('I\_us\_FA Zoom')

subplot(2,3,6)
imshow(I_us_FB_c(r,c),[])
title('I\_us\_FB Zoom')