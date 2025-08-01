import gleam/int
import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

fn pizza_price_total(pizza: Pizza, total: Int) -> Int {
  case pizza {
    Margherita -> 7 + total
    Caprese -> 9 + total
    Formaggio -> 10 + total
    ExtraSauce(pizza) -> pizza_price_total(pizza, total+1)
    ExtraToppings(pizza) -> pizza_price_total(pizza, total+2)
  }
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_total(pizza, 0)
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    [one] -> 3 + pizza_price(one)
    [one, two] -> 2 + pizza_price(one) + pizza_price(two)
    _ -> order |> list.map(pizza_price) |> int.sum 
  }
}
