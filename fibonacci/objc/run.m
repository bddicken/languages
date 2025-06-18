#import <Foundation/Foundation.h>
#import "fibonacci.h"
#import "benchmark.h"

/**
 * The work function called by benchmark_run.
 */
static benchmark_result_t work(void *data) {
    int* n = (int*)data;
    NSInteger result = fibonacci(*n);
    benchmark_result_t res;
    res.value.number = result;
    return res;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 4) {
            NSLog(@"Usage: %s <runMs> <warmupMs> <wordsFile>", argv[0]);
            return 1;
        }
        int runMs = atoi(argv[1]);
        int warmupMs = atoi(argv[2]);
        int n = atoi(argv[3]);

        // Warmup run (result is ignored)
        benchmark_run(work, &n, warmupMs);

        // Benchmark run.
        benchmark_stats_t stats = benchmark_run(work, &n, runMs);

        char buffer[1024];
        benchmark_format_results(stats, buffer, sizeof(buffer));
        printf("%s\n", buffer);
    }
    return 0;
}