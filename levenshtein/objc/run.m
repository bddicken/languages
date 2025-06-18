#import <Foundation/Foundation.h>
#import "levenshtein.h"
#import "benchmark.h"

/**
 * Reads words from a file, splitting on newline characters.
 * @param filePath A C-string representing the file path.
 * @return An NSArray of NSString objects containing each non-empty line in the file.
 */
NSArray<NSString *> *readWords(const char *filePath) {
    NSString *path = [NSString stringWithUTF8String:filePath];
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    if (!fileContents) {
        NSLog(@"Error reading file %@", path);
        return @[];
    }
    NSArray<NSString *> *lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSPredicate *nonEmpty = [NSPredicate predicateWithFormat:@"length > 0"];
    NSArray<NSString *> *words = [lines filteredArrayUsingPredicate:nonEmpty];
    return words;
}

/**
 * A struct to pass word data to the benchmark work function.
 */
typedef struct {
    NSArray<NSString *> *words;
} word_data_t;

/**
 * The work function called by benchmark_run.
 */
static benchmark_result_t work(void *data) {
    word_data_t *wd = (word_data_t *)data;
    NSInteger *result = distances(wd->words);
    benchmark_result_t res;
    res.value.ptr = result;
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
        const char *wordsFilePath = argv[3];

        NSArray<NSString *> *words = readWords(wordsFilePath);
        if (!words || words.count == 0) {
            NSLog(@"No words to process.");
            return 1;
        }

        // Set up the data for the benchmark.
        word_data_t data = { words };

        // Warmup run (result is ignored)
        benchmark_run(work, &data, warmupMs);

        // Benchmark run.
        benchmark_stats_t stats = benchmark_run(work, &data, runMs);

        NSInteger *distancesArray = (NSInteger *)stats.last_result.value.ptr;
        // Expected count based on unique pairs (i < j)
        NSUInteger count = (words.count * (words.count - 1)) / 2;
        NSInteger sum = 0;
        for (NSUInteger i = 0; i < count; i++) {
            sum += distancesArray[i];
        }
        stats.last_result.value.number = sum;

        char buffer[1024];
        benchmark_format_results(stats, buffer, sizeof(buffer));
        printf("%s\n", buffer);

        free(distancesArray);
    }
    return 0;
}