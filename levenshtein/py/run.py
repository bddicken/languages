import sys
import os
import levenshtein

sys.path.append(os.path.join(os.path.dirname(__file__), '../../lib/py'))
from benchmark import bench, format_bench

def main():
    args = sys.argv[1:]
    run_ms = int(args[0])
    warmup_ms = int(args[1])
    input_path = args[2]

    with open(input_path, "r") as f:
        strings = f.readlines()
        strings = [line.strip() for line in strings]

    # Warmup run
    if (warmup_ms > 0):
        bench(warmup_ms, lambda: levenshtein.distances(strings))

    # Benchmark run
    result = bench(run_ms, lambda: levenshtein.distances(strings))

    result['result'] = sum(result['result'])
    print(format_bench(result))

if __name__ == "__main__":
    main()
