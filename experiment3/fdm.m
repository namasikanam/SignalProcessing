% encode
[audio_LetItGo, fs] = audioread('LetItGo.mp3');
[audio_BlowinInTheWind, fs] = audioread('BlowinInTheWind.mp3');

% crop the first N samples of two radios
N = 1000000;
audio_LetItGo = audio_LetItGo(1: N);
audio_BlowinInTheWind = audio_BlowinInTheWind(1: N);
times = (1: N) / fs;
frequencies = (0: N - 1) / N * fs;

% Plot in time domain
figure('Name', 'Let It Go in Time Domain');
plot(times, audio_LetItGo, '.b');
xlabel('t (s)');
ylabel('Magnitude');

figure('Name', 'Blowin''In The Wind in Time Domain');
plot(times, audio_LetItGo, '.k');
xlabel('t (s)');
ylabel('Magnitude');

% FFT
dft_LetItGo = fft(audio_LetItGo);
dft_BlowinInTheWind = fft(audio_BlowinInTheWind);

% Plot in frequency domain
figure('Name', 'Let It Go in Frequency Domain');
plot(frequencies, abs(dft_LetItGo), '.b');
xlabel('frequency (Hz)');
ylabel('Magnitude');

figure('Name', 'Blowin''In The Wind in Frequency Domain');
plot(frequencies, abs(dft_LetItGo), '.k');
xlabel('frequency (Hz)');
ylabel('Magnitude');

% encode
dft = zeros(1, N);
% dft(1: N / 4) = dft_LetItGo(1: N / 4);
% dft(N / 4 + 1: N / 2) = dft_LetItGo(N * 3 / 4 + 1: N);
% dft(N / 2 + 1: N * 3 / 4) = dft_BlowinInTheWind(1: N / 4);
% dft(N * 3 / 4 + 1: N) = dft_BlowinInTheWind(N * 3 / 4 + 1: N);
dft(1: N / 8) = dft_LetItGo(1: N / 8);
dft(N / 4 + 1: N * 3 / 8) = dft_LetItGo(N * 7 / 8 + 1: N);
dft(N / 2 + 1: N * 5 / 8) = dft_BlowinInTheWind(1: N / 8);
dft(N * 3 / 4 + 1: N * 7 / 8) = dft_BlowinInTheWind(N * 7 / 8 + 1: N);

% Plot the encode result in frequency domain
figure('Name', 'Encoding result in Frequency Domain');
plot(frequencies, abs(dft), '.k');
xlabel('frequency (Hz)');
ylabel('Magnitude');

% Plot the encoding result in time domain
audio = ifft(dft);
audiowrite('mixed.wav', abs(audio) / max(abs(audio)), fs);

figure('Name', 'Encoding result in Time Domain');
plot(times, abs(audio_LetItGo), '.k');
xlabel('t (s)');
ylabel('Magnitude');

% decode
decoded_dft = fft(audio);
% dft_LetItGo = [dft(1: N / 4) zeros(1, N / 2) dft(N / 4 + 1: N / 2)];
% dft_BlowinInTheWind = [dft(N / 2 + 1: N * 3 / 4) zeros(1, N / 2) dft(N * 3 / 4 + 1: N)];
decoded_dft_LetItGo = [decoded_dft(1: N / 8) zeros(1, N * 3 / 4) decoded_dft(N / 4 + 1: N * 3 / 8)];
decoded_dft_BlowinInTheWind = [decoded_dft(N / 2 + 1: N * 5 / 8) zeros(1, N * 3 / 4) decoded_dft(N * 3 / 4 + 1: N * 7 / 8)];

% Plot in frequency domain
figure('Name', 'Decoded Let It Go in Frequency Domain');
plot(frequencies, abs(decoded_dft_LetItGo), '.b');
xlabel('frequency (Hz)');
ylabel('Magnitude');

figure('Name', 'Decoded Blowin''In The Wind in Frequency Domain');
plot(frequencies, abs(decoded_dft_LetItGo), '.k');
xlabel('frequency (Hz)');
ylabel('Magnitude');

% IFFT
decoded_audio_LetItGo = abs(ifft(decoded_dft_LetItGo));
decoded_audio_BlowinInTheWind = abs(ifft(decoded_dft_BlowinInTheWind));

% Plot in time domain
figure('Name', 'Decoded Let It Go in Time Domain');
plot(times, decoded_audio_LetItGo, '.b');
xlabel('t (s)');
ylabel('Magnitude');

figure('Name', 'Decoded Blowin''In The Wind in Time Domain');
plot(times, decoded_audio_LetItGo, '.k');
xlabel('t (s)');
ylabel('Magnitude');

% Write
audiowrite('decodedLetItGo.wav', decoded_audio_LetItGo / max(abs(decoded_audio_LetItGo)), fs);
audiowrite('decodedBlowinInTheWind.wav', decoded_audio_BlowinInTheWind / max(abs(decoded_audio_BlowinInTheWind)), fs);