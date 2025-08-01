import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string

fn real_digits(digits: List(String)) -> Result(List(Int), Nil) {
  list.map(digits, int.parse) |> result.all
}

fn digits_to_product(digits: List(String)) -> Result(Int, Nil) {
  real_digits(digits) |> result.map(list.fold(_, 1, int.multiply))
}

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  let digits_length = string.length(digits)

  case digits, int.compare(span, 0) {
    "", order.Gt -> Error(Nil)
    _, order.Lt -> Error(Nil)
    _, order.Eq -> Ok(1)
    _, _ -> {
      let windows = string.to_graphemes(digits) |> list.window(span)
      let products = list.map(windows, digits_to_product) |> result.all

      result.map(products, list.max(_, int.compare)) |> result.flatten
    }
  }
}
