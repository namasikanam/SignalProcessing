% Goertzel Algorithm
% The design of interface is referring to the standard [[goertzel]]
% Only integers in [0, length(data)) are acceptable for [[freq_indices]]
% The result are complex
function magnitude = my_goertzel(data, freq_indices)
    % In the context of slides, we use x(n) to denote data(n + 1) and k to denote
    % freq_indices(m)
    N = length(data);
    M = length(freq_indices);
    magnitude = zeros(1, M);
    for m = 1: M
        k = freq_indices(m);
        filter = 2 * cos(2 * pi * freq_indices(m) / N);
        v = zeros(1, N + 3);
        for n = 0: N - 1
            v(n + 3) = data(n + 1) + filter * v(n + 2) - v(n + 1); % data(n) ?? x(n)
        end
        v(N + 3) = filter * v(N + 2) - v(N + 1); % set data(N + 1) = x(N) = 0
        magnitude(m) = v(N + 3) - v(N + 2) * exp(-complex(0, 2 * pi * k / N));
    end
end