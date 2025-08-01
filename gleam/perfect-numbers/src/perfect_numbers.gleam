import gleam/float
import gleam/int
import gleam/list
import gleam/order

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

fn unique_divisor(number: Int, divisor: Int) -> Int {
  let other_divisor = number / divisor

  case other_divisor == divisor {
    True -> 0
    False -> other_divisor
  }
}

fn is_divisor(number: Int, divisor: Int) -> #(Int, Int) {
  case number % divisor == 0 {
    False -> #(0, 0)
    True -> #(divisor, unique_divisor(number, divisor))
  }
}

fn possible_divisors(number: Int) -> List(Int) {
  let assert Ok(square_root) = int.square_root(number)
  list.range(1, float.truncate(square_root))
}

fn divisor_sum(number: Int, sum: Int, possibilities: List(Int)) -> Int {
  case possibilities {
    [] -> sum
    [possible, ..rest] -> {
      let #(divisor1, divisor2) = is_divisor(number, possible)

      divisor_sum(number, sum + divisor1 + divisor2, rest)
    }
  }
}

fn aliquot_sum(number: Int) -> Int {
  divisor_sum(number, 0, possible_divisors(number)) - number
}

fn classify_aliquot(number: Int) -> Classification {
  case int.compare(aliquot_sum(number), number) {
    order.Eq -> Perfect
    order.Gt -> Abundant
    order.Lt -> Deficient
  }
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number > 0 {
    False -> Error(NonPositiveInt)
    True -> Ok(classify_aliquot(number))
  }
}
