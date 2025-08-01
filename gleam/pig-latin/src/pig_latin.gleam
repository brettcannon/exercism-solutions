import gleam/list
import gleam/string

fn reverse_and_join(letters: List(String)) -> String {
  list.reverse(letters) |> string.join(with: "")
}

fn consonant_start(word: String, consonants: List(String)) -> String {
  case word {
    "qu" <> rest -> rest <> reverse_and_join(consonants) <> "quay"
    "y" as vowel <> rest |
    "a" as vowel <> rest |
    "e" as vowel <> rest |
    "i" as vowel <> rest |
    "o" as vowel <> rest |
    "u" as vowel <> rest -> vowel <> rest <> reverse_and_join(consonants) <> "ay"
    _ -> {
      let assert Ok(#(consonant, rest)) = string.pop_grapheme(word)

      consonant_start(rest, [consonant, ..consonants])
    }
  }
}

fn translate_word(word: String) -> String {
  case word {
    "a" <> _ |
    "e" <> _ |
    "i" <> _ |
    "o" <> _ |
    "u" <> _ |
    "xr" <> _ |
    "yt" <> _ -> word <> "ay"
    "y" <> _ -> {
      let length = string.length(word) - 1

      string.slice(word, 1, length) <> "yay"
    }
    _ -> consonant_start(word, [])
  }
}

pub fn translate(phrase: String) -> String {
  string.split(phrase, on: " ") |> list.map(translate_word) |> string.join(with: " ")
}
