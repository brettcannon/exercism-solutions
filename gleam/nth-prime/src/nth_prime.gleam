import gleam/bool
import gleam/list

fn is_divisible(a: Int, b: Int) -> Bool {
  {a % b} == 0
}

fn is_prime(number: Int, primes: List(Int)) -> Bool {
  list.all(primes, fn (prime) {is_divisible(number, prime) |> bool.negate})
}

/// Calculate the nth prime.
/// It is assumed the initial list of primes includes 2.
fn nth_prime(current: Int, nth: Int, primes: List(Int)) -> Int {
  let next_current = current + 2  // Primes have to be odd passed 2

  case nth, is_prime(current, primes) {
    1, True -> current
    _, True -> nth_prime(next_current, nth - 1, [current, ..primes])
    _, False -> nth_prime(next_current, nth, primes)
  }
}

pub fn prime(number: Int) -> Result(Int, Nil) {
  case number {
    0 -> Error(Nil)
    1 -> Ok(2)
    _ -> Ok(nth_prime(3, number - 1, [2]))
  }
}
