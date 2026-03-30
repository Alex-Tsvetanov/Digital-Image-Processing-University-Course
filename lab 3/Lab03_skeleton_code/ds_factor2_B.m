function I_out = ds_factor2_B(I_in)

[M,N] = size(I_in);

% Adjust size to multiples of 4
M4 = floor(M/4)*4;
N4 = floor(N/4)*4;

I_in = I_in(1:M4,1:N4);

% Output image
I_out = zeros(M4/2, N4/2);

% ---------------------------------------------------------
% TODO: Implement Scheme B
% ---------------------------------------------------------
% Hint:
% step through the image with step 4
% copy the 2x2 block

for r = 1:4:M4
    for c = 1:4:N4
        r_out = floor(r/2) + 1;
        c_out = floor(c/2) + 1;
        I_out(r_out:r_out+1, c_out:c_out+1) = I_in(r:r+1, c:c+1);
    end
end

endfunction