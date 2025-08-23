// By ChatGPT-5 after initally solving w/o any AI help.
//
// This solution is simpler thanks to list.flat_map;
// I created my own list.extend() function and broke out a helper function to
// work directly on lists instead of NestedList only.
import gleam/list

pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  case nested_list {
    Null -> []
    Value(x) -> [x]
    List(xs) ->
      xs
      |> list.flat_map(fn(x) { flatten(x) })
  }
}
