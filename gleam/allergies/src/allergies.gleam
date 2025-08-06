import gleam/int
import gleam/list

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

const all_allergens = [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

fn allergen_to_bit(allergen: Allergen) -> Int {
  case allergen {
    Eggs -> 1
    Peanuts -> 2
    Shellfish -> 4
    Strawberries -> 8
    Tomatoes -> 16
    Chocolate -> 32
    Pollen -> 64
    Cats -> 128
  }
}

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  {allergen_to_bit(allergen) |> int.bitwise_and(score)} != 0
}

pub fn list(score: Int) -> List(Allergen) {
  list.filter(all_allergens, allergic_to(_, score))
}
