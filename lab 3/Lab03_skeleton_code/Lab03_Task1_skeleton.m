%% Task 1

pkg load image

% ---------------------------------------------------------
% 1. Load image
% ---------------------------------------------------------
% I = imread('siemens_star.png');
% I = imread('checkerboard_test.png');
% I = imread('kodim13.png');
% I = imread('Img08.tif');

% Convert to grayscale if needed
if ndims(I) == 3
    I = rgb2gray(I);
end

% Convert to double
I = im2double(I);

% ---------------------------------------------------------
% 2. Apply downsampling schemes
% ---------------------------------------------------------
I_ds_A = ds_factor2_A(I);
I_ds_B = ds_factor2_B(I);

% ---------------------------------------------------------
% 3. Visualization
% ---------------------------------------------------------
figure

subplot(1,3,1)
imshow(I,[])
title('Original')

subplot(1,3,2)
imshow(I_ds_A,[])
title('Scheme A')

subplot(1,3,3)
imshow(I_ds_B,[])
title('Scheme B')

% ---------------------------------------------------------
% 4. Display sizes
% ---------------------------------------------------------
fprintf('Original size : %d x %d\n', size(I,1), size(I,2));
fprintf('Scheme A size : %d x %d\n', size(I_ds_A,1), size(I_ds_A,2));
fprintf('Scheme B size : %d x %d\n', size(I_ds_B,1), size(I_ds_B,2));