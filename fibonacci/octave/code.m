function code()
    args = argv();  % Command-line arguments in Octave/Matlab
    u = str2double(args{1});  % Convert the first input argument to a double

    r = 0; % Initialize result
    for i = 1:u-1
        r = r + fibonacci(i); % Compute the Fibonacci sum
    end

    % Display the final result sum
    disp(r);
end

function result = fibonacci(n)
    % Recursive Fibonacci function
    if n == 0
        result = 0;
    elseif n == 1
        result = 1;
    else
        result = fibonacci(n-1) + fibonacci(n-2);
    end
end

code();
