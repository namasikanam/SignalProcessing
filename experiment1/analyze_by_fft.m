% Use FFT to analyze signal
% The interfaces are the same as [[my_goertzel]]
function magnitude = analyze_by_fft(data, freq_indices)
    M = length(freq_indices);
    magnitude = zeros(1, M);
    fft_data = fft(data);
    for m = 1: M
        magnitude(m) = fft_data(freq_indices(m) + 1);
    end
end