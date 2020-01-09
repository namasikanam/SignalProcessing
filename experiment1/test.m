% Script to test the performances of FFT and Goertzel Algorithm

% Generate 1M samples of the tone with a sample rate of 8 MHz.
Fs = 8000000;
N = 1000000;
f = [697 770 852 941 1209 1336 1477 1633];
% Choose the indices corresponding to the frequencies.
freq_indices = mod(round(f/Fs*N), N);

buttons = ['1', '2', '3', 'A';
		   '4', '5', '6', 'B';
		   '7', '8', '9', 'C';
		   '*', '0', '#', 'D'];

goertzel_correct_count = 0;
fft_correct_count = 0;
for l = 1: 4
    for h = 1: 4
        fprintf("\t\t%c & %d & %d", buttons(l, h), f(l), f(4 + h));
        
        lo = sin(2*pi*f(l)*(0:N-1)/Fs);
        hi = sin(2*pi*f(4+h)*(0:N-1)/Fs);
        data = lo + hi;

        % Use the Goertzel algorithm to compute the DFT of the tone.
        tic
        goertzel_data = my_goertzel(data,freq_indices);
        [~, L] = max(goertzel_data(1: 4));
        [~, H] = max(goertzel_data(5: 8));
        if L == l && H == h
            goertzel_correct_count = goertzel_correct_count + 1;
            fprintf(" & \\cmark");
        else
            fprintf(" & \\xmark");
        end
        fprintf(" & %d", round(toc * 1000000));
        
        % Use FFT to compute the DFT of the tone.
        tic
        fft_data = analyze_by_fft(data,freq_indices);
        [~, L] = max(fft_data(1: 4));
        [~, H] = max(fft_data(5: 8));
        if L == l && H == h
            fft_correct_count = fft_correct_count + 1;
            fprintf(" & \\cmark");
        else
            fprintf(" & \\xmark");
        end
        fprintf(" & %d", round(toc * 1000000));
        fprintf("\\\\\n");
    end
end
fprintf("The accuracy of Goertzel Algorithm is %d / %d\n", goertzel_correct_count, 16);
fprintf("The accuracy of FFT is %d / %d\n", fft_correct_count, 16);