import gleam/int
import gleam/list

fn square(x: Int) -> Int {
  x * x
}

pub fn square_of_sum(n: Int) -> Int {
  let sum = list.range(1, n) |> int.sum |> square
}

pub fn sum_of_squares(n: Int) -> Int {
  list.range(1, n) |> list.map(square) |> int.sum
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
