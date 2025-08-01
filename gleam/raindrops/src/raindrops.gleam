import gleam/int
import gleam/list
import gleam/string

fn make_sound_check(divisible_by: Int, sound: String) -> fn(Int) -> Result(String, Nil) {
  fn (number) {
    case number {
      _ if number % divisible_by == 0 -> Ok(sound)
      _ -> Error(Nil)
    }
  }
}

pub fn convert(number: Int) -> String {
  let checks = list.map([#(3, "Pling"), #(5, "Plang"), #(7, "Plong")], fn(x) {make_sound_check(x.0, x.1)})
  let sounds = list.filter_map(checks, fn(f) {f(number)})

  case sounds {
    [] -> int.to_string(number)
    _ -> string.join(sounds, "")
  }
}
