pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

fn extend(left: List(a), right: List(a)) -> List(a) {
  case left, right {
    [], [] -> []
    [], [item, ..rest] -> [item, ..extend([], rest)]
    [item, ..rest], _ -> [item, ..extend(rest, right)]
  }
}

fn flatten_list(list: List(NestedList(a))) -> List(a) {
  case list {
    [] -> []
    [Null, ..rest] -> flatten_list(rest)
    [Value(value), ..rest] -> [value, ..flatten_list(rest)]
    [List(contents), ..rest] ->
      flatten_list(contents) |> extend(flatten_list(rest))
  }
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  // Test cases allow for a simplified starting position:
  // let assert List(contents) = nested_list
  // flatten_list(contents)
  case nested_list {
    Null -> []
    Value(value) -> [value]
    List(contents) -> flatten_list(contents)
  }
}
