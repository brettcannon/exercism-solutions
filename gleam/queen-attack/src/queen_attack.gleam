import gleam/int

pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  case queen {
    Position(x, _) if x < 0 -> Error(RowTooSmall)
    Position(x, _) if x > 7 -> Error(RowTooLarge)
    Position(_, y) if y < 0 -> Error(ColumnTooSmall)
    Position(_, y) if y > 7 -> Error(ColumnTooLarge)
    _ -> Ok(Nil)
  }
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  let Position(black_x, black_y) = black_queen
  let Position(white_x, white_y) = white_queen

  case int.absolute_value(black_x - white_x), int.absolute_value(black_y - white_y) {
    0, _ -> True
    _, 0 -> True
    x_diff, y_diff if x_diff == y_diff -> True
    _, _ -> False
  }
}
