<?php

declare(strict_types=1);

function levenshtein_distance(string $str1, string $str2): int
{
    if (strlen($str2) < strlen($str1)) {
        return levenshtein_distance($str2, $str1);
    }
    $m = strlen($str1);
    $n = strlen($str2);
  
    $prev = [];
    $curr = [];

    for ($i = 0; $i <= $m; $i++) {
        $prev[$i] = $i;
    }
 
    // Compute Levenshtein distance
    for ($i = 1; $i <= $n; $i++) {
        $curr[0] = $i;
        for ($j = 1; $j <= $m; $j++) {
            $cost = 0;
            if($str1[$j - 1] != $str2[$i - 1]) {
                $cost = 1;
            }
            $curr[$j] = min(
                $prev[$j] + 1,        // Deletion
                $curr[$j - 1] + 1,        // Insertion
                $prev[$j - 1] + $cost // Substitution
            );
        }
        for ($j = 0; $j <= $m; $j++) {
            $prev[$j] = $curr[$j];
        }
    }
 
  //var_dump($prev);
  return $prev[$m];
}

// Main function to mimic C program's behavior
function main(array $args): void
{
    $minDistance = -1;
    $times = 0;

    foreach ($args as $i => $str1) {
        foreach ($args as $j => $str2) {
            if ($i != $j) {
                $distance = levenshtein_distance($str1, $str2);
                if ($minDistance == -1 || $minDistance > $distance) {
                    $minDistance = $distance;
                }

                $times++;
            }
        }
    }

    printf("times: %u\n", $times);
    printf("min_distance: %d\n", $minDistance);
}

// Skip script name.
unset($argv[0]);
// Call main.
main($argv);
