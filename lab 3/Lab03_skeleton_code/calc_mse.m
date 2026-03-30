function mse_val = calc_mse(I1, I2)
    D = I1 - I2;
    mse_val = mean(D(:).^2);

endfunction