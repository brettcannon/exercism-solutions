import gleam/int
import gleam/option.{type Option, Some, None}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player {
    Player(name: Some(name), ..) -> name
    _ -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player {
    Player(health: 0, level: level, ..) if level >= 10 ->
      Some(Player(..player, health: 100, mana: Some(100)))
    Player(health: 0, ..) -> Some(Player(..player, health: 100))
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player {
    Player(mana: Some(mana), ..) if mana >= cost ->
      #(Player(..player, mana: Some(mana - cost)), cost * 2)
    Player(mana: None, ..) -> #(Player(..player, health: int.max(0, player.health - cost)), 0)
    _ -> #(player, 0)
  }
}
