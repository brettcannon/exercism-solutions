import gleam/float

pub fn score(x: Float, y: Float) -> Int {
  let assert Ok(x_squared) = float.power(x, 2.0)
  let assert Ok(y_squared) = float.power(y, 2.0)
  let assert Ok(hypoteneus) = float.square_root(x_squared +. y_squared)

  case hypoteneus {
    _ if hypoteneus <=. 1.0 -> 10
    _ if hypoteneus <=. 5.0 -> 5
    _ if hypoteneus <=. 10.0 -> 1
    _ -> 0
  }
}
