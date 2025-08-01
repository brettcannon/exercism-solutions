import gleam/float
import gleam/int
import gleam/list
import gleam/result

pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case square {
    _ if square >= 1 && square <= 64 -> {
      let exponent = square - 1 |> int.to_float
      let assert Ok(value) = int.power(2, exponent)

      float.round(value) |> Ok
    }
    _ -> Error(InvalidSquare)
  }
}

pub fn total() -> Int {
  list.range(1, 64) |> list.map(square) |> result.all |> result.unwrap([]) |> int.sum
}
