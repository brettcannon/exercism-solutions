import gleam/list
import gleam/string

fn sorted_letters(word: String) -> List(String) {
  let word_parts = string.to_graphemes(word)

  list.sort(word_parts, string.compare)
}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let lowered_word = string.lowercase(word)
  let word_sorted = sorted_letters(lowered_word)

  list.filter(candidates, fn(candidate) {
    let lowered_candidate = string.lowercase(candidate)
    
    lowered_word != lowered_candidate && word_sorted == sorted_letters(lowered_candidate)})
}
