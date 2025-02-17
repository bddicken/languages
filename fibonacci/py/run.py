import sys
import os
import fibonacci

sys.path.append(os.path.join(os.path.dirname(__file__), '../../lib/py'))
from benchmark import bench, format_bench

def main():
    args = sys.argv[1:]
    run_ms = int(args[0])
    warmup_ms = int(args[1])
    n = int(args[2])

    # Warmup run
    if (warmup_ms > 0):
        bench(warmup_ms, lambda: fibonacci.fibonacci(n))

    # Benchmark run
    result = bench(run_ms, lambda: fibonacci.fibonacci(n))

    print(format_bench(result))

if __name__ == "__main__":
    main()
