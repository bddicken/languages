use num::{Integer, NumCast, Unsigned};
use num_convert::FromAs;

pub fn fibonacci<T>(number: T) -> T
where
    T: Unsigned + Integer + NumCast + Copy + FromAs<u8>,
{
    let one = T::one();
    let two = T::from_as(2);

    match number {
        n if n <= one => n,
        _ => fibonacci(number - one) + fibonacci(number - two),
    }
}
