import gleam/int
import gleam/list
import gleam/result
import gleam/string

/// 1-based indexing into a list.
///
fn index(list: List(t), idx: Int) -> Result(t, Nil) {
  case idx, list {
    _, _ if idx <= 0 -> Error(Nil)
    1, [item, ..] -> Ok(item)
    _, [] -> Error(Nil)
    _, [_, ..rest] -> index(rest, idx - 1)
  }
}

/// Convert a string separating rows by "\n" and item by " " into an NxM matrix.
/// Don't do any conversion of the items since it's potentially a waste of energy.
fn to_matrix(string: String) -> List(List(String)) {
  string.split(string, on: "\n") |> list.map(string.split(_, on: " "))
}

fn convert_row(matrix: List(List(String)), idx: Int) -> Result(List(Int), Nil) {
  use row <- result.try(index(matrix, idx))

  list.map(row, int.parse) |> result.all
}

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  to_matrix(string) |> convert_row(index)
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  to_matrix(string) |> list.transpose |> convert_row(index)
}
