#!/usr/bin/env fish

set -l u (math $argv[1])
set -l r (math (random) % 10000)
set -l a
for i in (seq 10000)
    set -a a 0
end

for i in (seq 10000)
    for j in (seq 100000)
        set a[$i] (math $a[$i] + $j % $u)
    end
    set a[$i] (math $a[$i] + $r)
end
echo $a[$r]
