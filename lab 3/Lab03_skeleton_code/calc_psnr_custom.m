function psnr_val = calc_psnr_custom(I1, I2, MAXval)
% MAXval = 1 for im2double images.

    mse_val = calc_mse(I1, I2);

    if mse_val == 0
        psnr_val = Inf;
    else
        psnr_val = 10 * log10((MAXval^2) / mse_val);
    end

endfunction