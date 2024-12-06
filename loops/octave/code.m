function code()
    % Get an input number from the command line
    u = str2double(argv(){1});  % Convert input to double

    % Generate a random number between 0 and 10000
    r = randi([0, 9999]);

    % Initialize an array of 10k elements to 0
    a = zeros(1, 10000);

    % Perform the nested loop operation
    for i = 1:10000  % 10k outer loop iterations
        for j = 0:99999  % 100k inner loop iterations, per outer loop iteration
            a(i) = a(i) + mod(j, u);  % Simple sum and mod operation
        end
        a(i) = a(i) + r;  % Add a random value to each element in array
    end

    disp(a(r + 1));  %  Print out a single element from the array
end

code();
