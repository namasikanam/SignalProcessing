% cf. https://en.wikipedia.org/wiki/Overlap%E2%80%93save_method
function y = conv_by_overlap_save(x, h)
   N = length(x);
   M = length(h); % we just use M as the length of the segmentation
   P = 2 * M - 1;
   H = fft(h, P);	% just calc once
   y = zeros(1, ceil((N + M - 1) / M) * M);
   for i = 0: ceil((N + M - 1) / M) - 1
       tx = [];
       if (i - 1) * M + 2 <= 0
           tx = [tx zeros(1, -(i - 1) * M - 1)];
           xl = 1;
       else
           xl = (i - 1) * M + 2;
       end
       tx = [tx x(xl: min((i + 1) * M, N))];
       
       yt = ifft(fft(tx, P) .* H, P);
       y(i * M + 1: (i + 1) * M) = yt(M: P);
   end
   y = y(1: M + N - 1);	% the first M+N-1 values are the convolution result
end