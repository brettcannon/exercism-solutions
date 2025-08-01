import gleam/list

pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

fn colour_to_num(colour: Color) -> Int {
  case colour {
    Black -> 0
    Brown -> 1
    Red -> 2
    Orange -> 3
    Yellow -> 4
    Green -> 5
    Blue -> 6
    Violet -> 7
    Grey -> 8
    White -> 9
  }
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  case colors {
    [tens, singles, ..rest] -> Ok({colour_to_num(tens) * 10} + colour_to_num(singles))
    _ -> Error(Nil)
  }
}
