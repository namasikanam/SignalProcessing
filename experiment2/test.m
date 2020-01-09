number_of_points = 15;

definition_times = zeros(1, number_of_points);
fft_times = zeros(1, number_of_points);
overlap_add_times = zeros(1, number_of_points);
overlap_save_times = zeros(1, number_of_points);
lengths = zeros(1, number_of_points);
for NI = 1: number_of_points
    N = 2 ^ NI;
    lengths(NI) = N
    
    x = rand([1, N]);
    h = rand([1, 512]);
    
    tic;
    conv_by_definition(x, h);
    definition_times(NI) = toc;
    
    tic;
    conv_by_fft(x, h);
    fft_times(NI) = toc;
    
    tic;
    conv_by_overlap_add(x, h);
    overlap_add_times(NI) = toc;
    
    tic;
    conv_by_overlap_save(x, h);
    overlap_save_times(NI) = toc;
end
figure('Name', 'Performance comparison of four linear convolution algorithm')
loglog(lengths, definition_times, '-+', lengths, fft_times, '--o', lengths, overlap_add_times, ':*', lengths, overlap_save_times, '-.x')
legend({'definition', 'fft', 'overlap\_add', 'overlap\_save'}, 'Location', 'northwest');
grid on