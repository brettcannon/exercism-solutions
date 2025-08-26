import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn to_digits(str: String) -> List(Int) {
  let parts = str |> string.to_graphemes |> list.reverse
  let digit_strings = case parts {
    ["X", ..rest] -> ["10", ..rest]
    _ -> parts
  }

  // Default to something that will fail the `% 11` check.
  digit_strings |> list.map(int.parse) |> result.all |> result.unwrap([42])
}

pub fn is_valid(isbn: String) -> Bool {
  let isbn = string.replace(isbn, each: "-", with: "")

  string.length(isbn) == 10 && 
  {isbn
    |> to_digits
    |> list.index_map(fn(x, i) {x * {i+1}})
    |> int.sum} % 11 == 0
}
