use rand::{thread_rng, Rng};
fn main() {
    let n: u32 = std::env::args()           // Get an input number from the command line
        .nth(1)
        .unwrap()
        .parse()
        .unwrap();
    
    let r:u32 = thread_rng().gen_range(0..10000);// Get a random number 0 <= r < 10k
        
    let mut a = [0u32; 10000];    // Array of 10k elements initialized to 0
    for i in 0..10000 {                  // 10k outer loop iterations
        for j in 0..100000 {               // 100k inner loop iterations, per outer loop iteration
            a[i] = a[i] + j % n;                // Simple sum
        }
        a[i] += r;                              // Add a random value to each element in array
    }
    println!("{}", a[r as usize]);              // Print out a single element from the array
}