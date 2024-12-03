#!/usr/bin/env fish

set -l u (math $argv[1])
set -l r (math (random) % 10000)
set -l a (seq 10000)

for i in $a
    set a[$i] (math $a[$i] + $r)
end
echo $a[$r]
