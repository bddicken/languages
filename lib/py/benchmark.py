import time
import sys

def variance(array):
    if len(array) < 2:
        return 0.0
    mean = sum(array) / len(array)
    return sum((x - mean) ** 2 for x in array) / (len(array) - 1)

def std_dev(array):
    return variance(array) ** 0.5

def bench(run_ms, func):
    times = []
    result = None
    run_ns = run_ms * 1_000_000

    while sum(times) < run_ns:
        start = time.monotonic_ns()
        result = func()
        end = time.monotonic_ns()
        elapsed = end - start
        times.append(elapsed)

        if run_ms > 1 and (sum(times) // 1_000_000_000) > (sum(times[:-1]) // 1_000_000_000):
            sys.stderr.write('.')
            sys.stderr.flush()

    if run_ms > 1:
        sys.stderr.write('\n')

    return {
        'times': times,
        'result': result
    }

def format_bench(data):
    if not data['times']:
        raise ValueError("no data!")

    result = data['result']
    times = [t / 1_000_000 for t in data['times']]  # convert to milliseconds

    # mean_ms,std-dev-ms,min_ms,max_ms,times,result
    return f"{sum(times) / len(times)},{std_dev(times)},{min(times)},{max(times)},{len(times)},{result}"