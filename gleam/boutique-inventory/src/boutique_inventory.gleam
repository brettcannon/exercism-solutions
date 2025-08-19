import gleam/yielder.{type Yielder}

pub type Item {
  Item(name: String, price: Int, quantity: Int)
}

pub fn item_names(items: Yielder(Item)) -> Yielder(String) {
  items |> yielder.map(fn(i) {i.name})
}

pub fn cheap(items: Yielder(Item)) -> Yielder(Item) {
  items |> yielder.filter(fn(i) {i.price < 30})
}

pub fn out_of_stock(items: Yielder(Item)) -> Yielder(Item) {
  items |> yielder.filter(fn(i) {i.quantity < 1})
}

pub fn total_stock(items: Yielder(Item)) -> Int {
  items |> yielder.fold(0, fn(accum, i) {accum + i.quantity})
}