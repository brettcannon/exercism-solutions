import gleam/string

pub opaque type TreasureChest(treasure) {
  TreasureChest(password: String, contents: treasure)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case string.length(password) >= 8 {
    True -> Ok(TreasureChest(password:, contents:))
    False -> Error("Password must be at least 8 characters long")
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case password == chest.password {
    True -> Ok(chest.contents)
    False -> Error("Incorrect password")
  }
}
