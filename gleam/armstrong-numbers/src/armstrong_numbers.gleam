import gleam/int
import gleam/list

fn pow(base: Int, exponent: Int) -> Int {
  // Taking some shortcuts knowing how the input will be structured.
  case exponent {
    1 -> base
    _ -> base * pow(base, exponent - 1)
  }
}

pub fn is_armstrong_number(number: Int) -> Bool {
  let assert Ok(digits) = int.digits(number, 10)
  let exponent = list.length(digits)

  // You can't use int.power() because it returns a float and can overflow.
  let total = digits |> list.map(pow(_, exponent)) |> int.sum

  total == number
}
