function I_out = upsample_nn_x2(I_in)

[M, N] = size(I_in);

I_out = zeros(2*M, 2*N);

% ---------------------------------------------------------
% TODO
% Implement nearest-neighbor upscaling
% ---------------------------------------------------------
% Hint:
% for each input pixel, copy it into a 2x2 block in the output

for r = 1:M
    for c = 1:N
        I_out(2*r-1:2*r, 2*c-1:2*c) = I_in(r, c);
    end
end

endfunction