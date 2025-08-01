import gleam/list
import gleam/set
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  let letters_set = set.from_list(letters)
  let sentence_set = sentence |> string.lowercase |> string.to_graphemes |> list.filter(set.contains(letters_set, _)) |> set.from_list

  letters_set == sentence_set
}
