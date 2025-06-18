use std::ops::AddAssign;

use num::{FromPrimitive, Integer, NumCast, ToPrimitive, Unsigned};
use num_convert::FromAs;
use rand::{distr::uniform::SampleUniform, Rng};

pub fn loops<N, R, const ITERATIONS_OUTER: usize, const ITERATIONS_INNER: usize>(divisor: N) -> N
where
    N: Unsigned + Integer + Copy + FromPrimitive + NumCast + AddAssign,
    R: Unsigned + Integer + Copy + ToPrimitive + SampleUniform + FromAs<u16>,
{
    // get a random number 0 <= r < 10k
    let rng_range = R::zero()..R::from_as(10_000);
    let random: R = rand::rng().random_range(rng_range);

    // array of outer iterations length initialized to 0
    let mut arr = [N::zero(); ITERATIONS_OUTER];

    // outer loop iterations
    // iterate over array itself to prevent permanent bound checks for arr[i]
    for elem in &mut arr {
        // inner loop iterations, per outer loop iteration
        for i in 0..ITERATIONS_INNER {
            // simple sum
            *elem += N::from_usize(i).expect("valid dividend") % divisor;
        }

        // add a random value to each element in array
        *elem += N::from(random).expect("valid number");
    }

    arr[random.to_usize().expect("valid index")]
}
