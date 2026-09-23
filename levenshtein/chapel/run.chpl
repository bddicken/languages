use Benchmark;
use IO;
use List;

var words: list(bytes);

var wordsDom: domain(1) = {0..-1};
var wordsArr: [wordsDom] bytes;

var pairsDom: domain(1) = {0..-1};
var lastDistances: [pairsDom] int;

var scratchDom: domain(1) = {0..0};
var previous: [scratchDom] int;
var current: [scratchDom] int;

proc levenshtein(a: bytes, b: bytes): int {
  const first = if a.size <= b.size then a else b;
  const second = if a.size <= b.size then b else a;

  const m = first.size;
  const n = second.size;

  for j in 0..m do previous[j] = j;

  for i in 1..n {
    current[0] = i;
    const secondByte = second[i - 1];

    for j in 1..m {
      const cost = if first[j - 1] == secondByte then 0 else 1;
      var best = previous[j] + 1;
      const ins = current[j - 1] + 1;
      if ins < best then best = ins;
      const sub = previous[j - 1] + cost;
      if sub < best then best = sub;
      current[j] = best;
    }

    previous <=> current;
  }

  return previous[m];
}

proc calculateDistances() {
  var idx = 0;

  for firstIndex in 0..<wordsArr.size {
    for secondIndex in (firstIndex + 1)..<wordsArr.size {
      lastDistances[idx] = levenshtein(wordsArr[firstIndex], wordsArr[secondIndex]);
      idx += 1;
    }
  }
}

proc benchmarkDistances(_dummy: int): int {
  calculateDistances();
  return 0;
}

proc sumDistances(): int {
  var sum = 0;
  for distance in lastDistances do sum += distance;
  return sum;
}

proc readWords(filename: string) throws {
  var file = open(filename, ioMode.r);
  var reader = file.reader(locking=false);

  for line in reader.lines(stripNewline=true) {
    words.pushBack(line.encode());
  }

  reader.close();
  file.close();

  const count = words.size;
  wordsDom = {0..<count};

  var maxLen = 0;
  for (i, w) in zip(0..<count, words) {
    wordsArr[i] = w;
    if w.size > maxLen then maxLen = w.size;
  }

  scratchDom = {0..maxLen};

  const pairCount = if count < 2 then 0 else count * (count - 1) / 2;
  pairsDom = {0..<pairCount};
}

proc main(args: [] string) throws {
  const runMs = args[1]: int;
  const warmupMs = args[2]: int;
  const inputPath = args[3];

  readWords(inputPath);

  Benchmark.run(warmupMs, benchmarkDistances, 0);

  const benchmark = Benchmark.run(runMs, benchmarkDistances, 0);

  const checksum = sumDistances();

  writeln(Benchmark.formatResults(benchmark, checksum));
}