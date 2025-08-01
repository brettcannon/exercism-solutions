import gleam/bool
import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  let already_exists = set.contains(collection, card)

  #(already_exists, bool.guard(already_exists, collection, fn() {set.insert(collection, card)}))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let have_mine = set.contains(collection, my_card)
  let missing_theirs = set.contains(collection, their_card) |> bool.negate
  let after_trade = collection |> set.drop([my_card]) |> set.insert(their_card)

  #(bool.and(have_mine, missing_theirs), after_trade)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case list.first(collections) {
    Ok(first_set)  -> list.fold(collections, first_set, set.intersection) |> set.to_list |> list.sort(string.compare)
    Error(Nil) -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  list.fold(collections, set.new(), set.union) |> set.size
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, string.starts_with(_, "Shiny "))
}
