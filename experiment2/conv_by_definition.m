% The indices in codes and slides are different by 1
function y = conv_by_definition(x, h)
    xs = length(x);
    hs = length(h);
    ys = xs + hs - 1;
    
    X = zeros(1, ys);
    for k = 0: ys - 1
        for n = 0: xs - 1
            X(k + 1) = X(k + 1) + x(n + 1) * exp(-complex(0, 2 * pi * k / ys));
        end
    end
    
    H = zeros(1, ys);
    for k = 0: ys - 1
        for n = 0: hs - 1
            H(k + 1) = H(k + 1) + h(n + 1) * exp(-complex(0, 2 * pi * k / ys));
        end
    end
    
    Y = X .* H;
    y = zeros(1, ys);
    for k = 0: ys - 1
        for n = 0: ys - 1
            Y(k + 1) = Y(k + 1) + y(n + 1) * exp(complex(0, 2 * pi * k / ys));
        end
    end
    y = y / ys;
end