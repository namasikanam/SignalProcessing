% cf. https://en.wikipedia.org/wiki/Overlap%E2%80%93add_method
function y = conv_by_overlap_add(x, h)
    % Evaluate the best value of N and L (L > 0, N = M + L - 1 nearest to power of 2).
    M = length(h);
    N = 2 ^ ceil(log(M));
    L = N + 1 - M;
    
    xs = length(x);
    H = fft(h, N);
    y = zeros(1, M + xs - 1);
    for i = 1:L:xs
        il = min(i + L - 1, xs);
        yt = ifft(fft(x(i:il), N) .* H, N);
        k = min(i + N - 1, M + xs - 1);
        y(i:k) = y(i:k) + yt(1:k - i + 1);    % (add the overlapped output blocks)
    end
end