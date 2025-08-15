import gleam/dict
import gleam/list
import gleam/result
import gleam/string

const plain = "abcdefghijklmnopqrstuvwxyz"
const cipher = "zyxwvutsrqponmlkjihgfedcba"
const digits = "0123456789"

fn strings_to_zip(left: String, right: String) -> List(#(String, String)) {
  let left_list = string.to_graphemes(left)
  let right_list = string.to_graphemes(right)

  list.zip(left_list, right_list)
}

fn dict_from_strings(keys: String, values: String) -> dict.Dict(String, String) {
  strings_to_zip(keys, values) |> dict.from_list
}

fn new_mapping(keys: String, values: String) -> dict.Dict(String, String) {
  let letter_cipher = dict_from_strings(keys, values)
  let digits_cipher = dict_from_strings(digits, digits)

  dict.merge(letter_cipher, digits_cipher)
}

fn cleanup(phrase: String) -> String {
  phrase |> string.lowercase |> string.replace(".", "") |> string.replace(",", "") |> string.replace(" ", "")
}

fn dict_get(dict_: dict.Dict(String, String), key: String) -> String {
  dict.get(dict_, key) |> result.unwrap("😱")
}

fn translate(phrase: String, cipher: dict.Dict(String, String)) -> List(String) {
  let clean_phrase = cleanup(phrase)

  string.to_graphemes(clean_phrase) |> list.map(dict_get(cipher, _))
}

pub fn encode(phrase: String) -> String {
  let encoder = new_mapping(plain, cipher)

  phrase |> translate(encoder) |> list.sized_chunk(5)  |> list.map(string.join(_, "")) |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  let decoder = new_mapping(cipher, plain)

 phrase |> translate(decoder) |> string.join("")
}
