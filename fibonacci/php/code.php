<?php

function fibonacci(int $n): int
{
    if ($n == 0) return 0;
    if ($n == 1) return 1;
    return fibonacci($n - 1) + fibonacci($n - 2);
}

$u = (int) $argv[1];
$r = 0;
for ($i = 0; $i < $u; $i++) {
    $r += fibonacci($i);
}
echo $r;
