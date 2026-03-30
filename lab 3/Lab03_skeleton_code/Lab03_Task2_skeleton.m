%% Task 2

pkg load image

% ---------------------------------------------------------
% 1. Load image
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
% 2. Apply Gaussian low-pass filtering
% ---------------------------------------------------------
% TODO
% Create Gaussian filter and apply it to the image

h = fspecial('gaussian', [7 7], 1.0);
I_filt = imfilter(I, h, 'replicate', 'same');

% ---------------------------------------------------------
% 3. Downsampling
% ---------------------------------------------------------
% From Task 1 functions

I_ds_A = ds_factor2_A(I);
I_ds_B = ds_factor2_B(I);

% TODO
% Apply the same schemes after filtering

I_ds_FA = ds_factor2_A(I_filt);
I_ds_FB = ds_factor2_B(I_filt);

% ---------------------------------------------------------
% 4. Reference image
% ---------------------------------------------------------
I_r = imresize(I,0.5,'bicubic');

% ---------------------------------------------------------
% 5. Compute MSE
% ---------------------------------------------------------
% TODO
% Implement MSE computation

rA_h = min(size(I_r,1), size(I_ds_A,1));
rA_w = min(size(I_r,2), size(I_ds_A,2));
mse_A  = calc_mse(I_r(1:rA_h, 1:rA_w), I_ds_A(1:rA_h, 1:rA_w));

rB_h = min(size(I_r,1), size(I_ds_B,1));
rB_w = min(size(I_r,2), size(I_ds_B,2));
mse_B  = calc_mse(I_r(1:rB_h, 1:rB_w), I_ds_B(1:rB_h, 1:rB_w));

rFA_h = min(size(I_r,1), size(I_ds_FA,1));
rFA_w = min(size(I_r,2), size(I_ds_FA,2));
mse_FA = calc_mse(I_r(1:rFA_h, 1:rFA_w), I_ds_FA(1:rFA_h, 1:rFA_w));

rFB_h = min(size(I_r,1), size(I_ds_FB,1));
rFB_w = min(size(I_r,2), size(I_ds_FB,2));
mse_FB = calc_mse(I_r(1:rFB_h, 1:rFB_w), I_ds_FB(1:rFB_h, 1:rFB_w));

% ---------------------------------------------------------
% 6. Compute PSNR
% ---------------------------------------------------------
% MAX = 1 because images are in double format

% TODO
% Implement PSNR formula

psnr_A  = calc_psnr_custom(I_r(1:rA_h, 1:rA_w), I_ds_A(1:rA_h, 1:rA_w), 1);
psnr_B  = calc_psnr_custom(I_r(1:rB_h, 1:rB_w), I_ds_B(1:rB_h, 1:rB_w), 1);
psnr_FA = calc_psnr_custom(I_r(1:rFA_h, 1:rFA_w), I_ds_FA(1:rFA_h, 1:rFA_w), 1);
psnr_FB = calc_psnr_custom(I_r(1:rFB_h, 1:rFB_w), I_ds_FB(1:rFB_h, 1:rFB_w), 1);

% ---------------------------------------------------------
% 7. Display results
% ---------------------------------------------------------
fprintf('Variant        MSE          PSNR\n');
fprintf('------------------------------------\n');

fprintf('I_ds_A   : %f   %f\n', mse_A, psnr_A);
fprintf('I_ds_B   : %f   %f\n', mse_B, psnr_B);
fprintf('I_ds_FA  : %f   %f\n', mse_FA, psnr_FA);
fprintf('I_ds_FB  : %f   %f\n', mse_FB, psnr_FB);

% ---------------------------------------------------------
% 8. Visualization
% ---------------------------------------------------------
figure

subplot(2,3,1)
imshow(I_r,[])
title('Reference')

subplot(2,3,2)
imshow(I_ds_A,[])
title('I\_ds\_A')

subplot(2,3,3)
imshow(I_ds_B,[])
title('I\_ds\_B')

subplot(2,3,5)
imshow(I_ds_FA,[])
title('I\_ds\_FA')

subplot(2,3,6)
imshow(I_ds_FB,[])
title('I\_ds\_FB')

% ---------------------------------------------------------
% 9. Zoom comparison
% ---------------------------------------------------------
% Select a small region and show zoomed images
r = min(100:200, size(I_r,1));
c = min(100:200, size(I_r,2));

figure
subplot(2,3,1)
imshow(I_r(r,c),[])
title('Reference Zoom')

subplot(2,3,2)
imshow(I_ds_A(r,c),[])
title('I\_ds\_A Zoom')

subplot(2,3,3)
imshow(I_ds_B(r,c),[])
title('I\_ds\_B Zoom')

subplot(2,3,5)
imshow(I_ds_FA(r,c),[])
title('I\_ds\_FA Zoom')

subplot(2,3,6)
imshow(I_ds_FB(r,c),[])
title('I\_ds\_FB Zoom')