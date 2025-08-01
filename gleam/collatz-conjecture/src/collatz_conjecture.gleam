import gleam/int

pub type Error {
  NonPositiveNumber
}

fn steps_count(number: Int, count: Int) -> Int {
  let is_even = int.is_even(number)

  case number {
    1 -> count
    _ if is_even -> steps_count(number / 2, count+1)
    _ -> steps_count(number * 3 + 1, count+1)
  }
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number <= 0 {
    True -> Error(NonPositiveNumber)
    False -> Ok(steps_count(number, 0))
  }
}
