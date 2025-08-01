import gleam/list
import gleam/string

fn ham_distance(pairs: List(#(String, String)), accum: Int) -> Int {
  case pairs {
    [] -> accum
    [#(lhs, rhs), ..rest] if lhs != rhs -> ham_distance(rest, accum + 1)
    [_, ..rest] -> ham_distance(rest, accum)
  }
}

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  
  case string.length(strand1) == string.length(strand2) {
      True -> Ok(ham_distance(list.zip(string.to_graphemes(strand1), string.to_graphemes(strand2)), 0))
      False -> Error(Nil)
  }
}
