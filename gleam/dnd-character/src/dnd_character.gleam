import gleam/int
import gleam/list
import gleam/result

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

fn roll() -> Int {
  int.random(6) + 1
}

pub fn generate_character() -> Character {
  let strength = ability()
  let dexterity = ability()
  let constitution = ability()
  let intelligence = ability()
  let wisdom = ability()
  let charisma = ability()

  Character(charisma:, constitution:, dexterity:, intelligence:, strength:, wisdom:, hitpoints: 10 + modifier(constitution))
}

pub fn modifier(score: Int) -> Int {
  case int.floor_divide(score - 10, 2) {
    Ok(div) -> div
    Error(Nil) -> 0
  }
}

pub fn ability() -> Int {
  list.map(list.range(1, 4), fn(_) {roll()}) |> list.sort(int.compare) |> list.rest |> result.unwrap(or: []) |> int.sum
}
