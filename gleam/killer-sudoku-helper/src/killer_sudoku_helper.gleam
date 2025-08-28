import gleam/bool
import gleam/int
import gleam/list

pub fn combinations(
  size size: Int,
  sum sum: Int,
  exclude exclude: List(Int),
) -> List(List(Int)) {
  list.range(1, 9)
  |> list.filter(fn(n) {list.contains(exclude, n) |> bool.negate})
  |> list.combinations(size)
  |> list.filter(fn(combo) {int.sum(combo) == sum})
}
