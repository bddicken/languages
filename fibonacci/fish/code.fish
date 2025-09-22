#!/usr/bin/env fish

function fibonacci
    if test $argv[1] -eq 0
        echo 0
    else if test $argv[1] -eq 1
        echo 1
    else
        echo (fibonacci (math $argv[1] - 1)) + (fibonacci (math $argv[1] - 2))
    end
end

set -l u (math $argv[1] - 1)
set -l r 0
for i in (seq 0 $u)
    set r (math $r + (fibonacci $i))
end
echo $r
