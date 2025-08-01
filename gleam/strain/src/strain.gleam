import gleam/bool
import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  list.filter(list, predicate)
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  list.filter(list, fn (x) {bool.negate(predicate(x))})
}
