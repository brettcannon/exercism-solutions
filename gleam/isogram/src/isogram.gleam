import gleam/list
import gleam/set
import gleam/string


fn seen_yet(
  so_far: #(set.Set(String), Int),
  letter: String,
) -> #(set.Set(String), Int) {
  let #(seen, skipped) = so_far

  case letter {
    "-" | " " -> #(seen, skipped + 1)
    _ -> #(set.insert(seen, letter), skipped)
  }
}

pub fn is_isogram(phrase phrase: String) -> Bool {
  let normalized_phrase = string.lowercase(phrase)
  let letters = string.to_graphemes(normalized_phrase)
  let #(seen, skipped) = list.fold(letters, #(set.new(), 0), seen_yet)

  list.length(letters) == { set.size(seen) + skipped }
}
