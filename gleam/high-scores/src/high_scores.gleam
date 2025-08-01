import gleam/int
import gleam/list
import gleam/order
import gleam/result

fn reverse_sort(list: List(Int)) -> List(Int) {
  list.sort(list, order.reverse(int.compare))
}

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  list.last(high_scores)
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  // Gleam stdlib version is too old to have list.max.
  high_scores |> reverse_sort |> list.first
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  let #(top_three, _) = high_scores |> reverse_sort |> list.split(3)

  top_three
}
