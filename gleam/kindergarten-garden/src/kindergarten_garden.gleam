import gleam/list
import gleam/result
import gleam/string


pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

const roll_call = [
  Alice,
  Bob,
  Charlie,
  David,
  Eve,
  Fred,
  Ginny,
  Harriet,
  Ileana,
  Joseph,
  Kincaid,
  Larry,
]

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

fn convert(codes: List(String)) -> List(Plant) {
  list.map(codes, fn(code) {
    case code {
      "G" -> Grass
      "C" -> Clover
      "R" -> Radishes
      "V" -> Violets
      _ -> panic
    }
  })
}

fn find(cups: List(#(Student, List(String))), student: Student) -> List(String) {
  case cups {
    [] -> []
    [#(s, plants), ..] if s == student -> plants
    [_, ..rest] -> find(rest, student)
  }
}

fn pair_chunks(chunks: List(List(String))) -> List(#(Student, List(String))) {
  list.zip(roll_call, chunks)
}

fn row_to_chunks(row: String) -> List(List(String)) {
  string.to_graphemes(row) |> list.sized_chunk(2)
}

fn split_diagram(diagram: String) -> #(String, String) {
  string.split_once(diagram, "\n") |> result.unwrap(#("", ""))
}

fn gather_plants(
  pairings: List(List(#(Student, List(String)))),
  student: Student,
) -> List(List(String)) {
  case pairings {
    [] -> []
    [pairing, ..rest] -> [
      find(pairing, student),
      ..gather_plants(rest, student)
    ]
  }
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let #(row1, row2) = split_diagram(diagram)
  let rows = [row_to_chunks(row1), row_to_chunks(row2)]
  let pairings = list.map(rows, pair_chunks)
  let found_plants = gather_plants(pairings, student) |> list.flatten

  convert(found_plants)
}
