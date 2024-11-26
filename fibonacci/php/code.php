<?php

function fibonacci($n)
{
    return fibonacci_accumulator($n, 0, 1);
}

function fibonacci_accumulator($n, $a, $b) 
{
  if ($n == 0) return $a;
  return fibonacci_accumulator($n - 1, $b, $a + $b);
}

$u = (int) $argv[1];
$r = 0;
for ($i = 0; $i < $u; $i++) {
    $r += fibonacci($i);
}
echo $r;
