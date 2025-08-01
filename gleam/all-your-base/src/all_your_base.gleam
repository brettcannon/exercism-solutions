import gleam/int
import gleam/list

pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

// The exponent is assumed to be positive.
fn pow(base: Int, exponent: Int) -> Int {
  case exponent {
    0 -> 1
    _ -> base * pow(base, exponent - 1)
  }
}


fn to_base10(digits: List(Int), base: Int) -> Int {
  case digits {
    [] -> 0
    [d] -> d
    [d, ..rest] -> {d * pow(base, list.length(rest))} + to_base10(rest, base)
  }
}

fn to_base_n_digits(number: Int, base: Int, digits: List(Int)) -> List(Int) {
  let digit = number % base
  let remaining = number - digit

  case remaining <= 0 {
    True -> [digit, ..digits]
    False -> to_base_n_digits(remaining / base, base, [digit, ..digits])
  }
}

fn to_base_n(number: Int, base: Int) -> List(Int) {
  to_base_n_digits(number, base, [])
}


pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  case input_base <= 1, output_base <= 1, list.find(digits, fn (d) {d >= input_base || d < 0}) {
    True, _, _ -> Error(InvalidBase(input_base))
    _, True, _ -> Error(InvalidBase(output_base))
    _, _, Ok(bad_digit) -> Error(InvalidDigit(bad_digit))
    _, _, _ -> digits |> to_base10(input_base) |> to_base_n(output_base) |> Ok
  }
}
