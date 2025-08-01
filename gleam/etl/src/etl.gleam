import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  use new_values, points, letters <- dict.fold(legacy, dict.new())
  use accum, letter <- list.fold(letters, new_values)
  let lower_letter = string.lowercase(letter)

  dict.insert(accum, lower_letter, points)  
}