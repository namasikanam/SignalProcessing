function y = conv_by_fft(x, h)
    N = length(x) + length(h) - 1;
    X = fft(x, N);
    H = fft(h, N);
    Y = X .* H;
    y = ifft(Y, N);
end