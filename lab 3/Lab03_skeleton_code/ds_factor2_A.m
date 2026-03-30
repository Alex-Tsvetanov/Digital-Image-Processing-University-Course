function I_out = ds_factor2_A(I_in)

[M,N] = size(I_in);

% Allocate output image
I_out = zeros(floor(M/2), floor(N/2));

% ---------------------------------------------------------
% TODO: Implement Scheme A
% ---------------------------------------------------------
% Hint:
% every second row and every second column

I_out = I_in(1:2:2*floor(M/2), 1:2:2*floor(N/2));

endfunction