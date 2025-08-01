pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [head, ..rest] -> [fun(head), ..accumulate(rest, fun)]
  }
}
