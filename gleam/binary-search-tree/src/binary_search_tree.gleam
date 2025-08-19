import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

fn insert(tree: Tree, new_data: Int) -> Tree {
  case tree {
    Nil -> Node(new_data, Nil, Nil)
    Node(data, left, _) if new_data <= data -> Node(..tree, left: insert(left, new_data))
    Node(data, _, right)  -> Node(..tree, right: insert(right, new_data))
  }
}

pub fn to_tree(data: List(Int)) -> Tree {
  list.fold(data, Nil, insert)
}

fn do_sort(tree: Tree, accum: List(Int)) -> List(Int) {
  case tree {
    Nil -> accum
    Node(data, Nil, Nil) -> [data, ..accum]
    Node(data, left, right) -> do_sort(left, [data, ..do_sort(right, accum)])
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  to_tree(data) |> do_sort([])
}
