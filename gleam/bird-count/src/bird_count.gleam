import gleam/int
import gleam/list
import gleam/result

pub fn today(days: List(Int)) -> Int {
  days |> list.first |> result.unwrap(0)
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [head, ..rest] -> [head + 1, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  days |> list.any(fn (c) {c == 0})
}

pub fn total(days: List(Int)) -> Int {
  days |> list.fold(0, int.add)
}

pub fn busy_days(days: List(Int)) -> Int {
  days |> list.filter(fn (c) {c >= 5}) |> list.length
}
