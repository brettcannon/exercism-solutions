import gleam/bool
import gleam/result
import gleam/string

import exercism/test_runner.{ debug }

pub fn hey(remark: String) -> String {
  let trimmed = string.trim(remark)
  // Watch out for non-alphanumeric characters which are simultaneously upper and lowercase.
  let is_upper = string.uppercase(trimmed) == trimmed && string.lowercase(trimmed) != string.uppercase(trimmed)
  let is_question = {string.last(trimmed) |> result.unwrap("")} == "?"
  let silence = string.trim(trimmed) |> string.is_empty

  case is_upper, is_question, silence {
    _, _, True -> "Fine. Be that way!"
    True, True, _ -> "Calm down, I know what I'm doing!"
    True, _, _ -> "Whoa, chill out!"
    _, True, _ -> "Sure."
    _, _, _ -> "Whatever."
  }
}
