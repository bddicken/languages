export function loops(u:i32):i32 {                // Get an input number from the command line
  let r = i32(Math.floor(Math.random() * 10000)); // Get a random number 0 <= r < 10k
  let a = new StaticArray<i32>(10000);            // Array of 10k elements initialized to 0
  for (let i = 0; i < 10000; i++) {               // 10k outer loop iterations
    for (let j = 0; j < 100000; j++) {            // 100k inner loop iterations, per outer loop iteration
      a[i] += j%u;                                // Simple sum
    }
    a[i] += r;                                    // Add a random value to each element in array
  }
  return a[r];
}
