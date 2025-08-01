import gleam/int
import gleam/result

fn divide(numerator, denominator) {int.floor_divide(numerator, denominator) |> result.unwrap(0)}

pub fn convert(number: Int) -> String {
  case number {
    x if  x >= 1000 -> "M" <> convert(number - 1000)
    x if x >= 900 -> "CM" <> convert(number - 900)
    x if x >= 500 -> "D" <> convert(number - 500)
    x if x >= 400 -> "CD" <> convert(number - 400)
    x if x >= 100 -> "C" <> convert(number - 100)
    x if x >= 90 -> "XC" <> convert(number - 90)
    x if x >= 50 -> "L" <> convert(number - 50)
    x if x >= 40 -> "XL" <> convert(number - 40)
    x if x >= 10 -> "X" <> convert(number - 10)
    x if x >= 9 -> "IX" <> convert(number - 9)
    x if x >= 5 -> "V" <> convert(number - 5)
    x if x >= 4 -> "IV" <> convert(number - 4)
    x if x >= 1 -> "I" <> convert(number - 1)
    _ -> ""
  }
}
