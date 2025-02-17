import sys
import os
import loops

sys.path.append(os.path.join(os.path.dirname(__file__), '../../lib/py'))
from benchmark import bench, format_bench

def main():
    args = sys.argv[1:]
    run_ms = int(args[0])
    warmup_ms = int(args[1])
    u = int(args[2])

    # Warmup run
    if (warmup_ms > 0):
        bench(warmup_ms, lambda: loops.loops(u))

    # Benchmark run
    result = bench(run_ms, lambda: loops.loops(u))

    print(format_bench(result))

if __name__ == "__main__":
    main()
