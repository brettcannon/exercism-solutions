import gleam/list
import gleam/string

fn abbrev(word: String) -> String {
  case string.slice(word, at_index: 0, length: 1) {
    // Not robust, but lack of a `isalpha` function in the standard library makes this a pain.
    "_" -> string.slice(word, at_index: 1, length: 1)
    letter -> letter 
  }
}

pub fn abbreviate(phrase phrase: String) -> String {
  string.replace(phrase, each: "-", with: " ") |> string.split(" ") |> list.map(abbrev) |> string.join("") |> string.uppercase
}
