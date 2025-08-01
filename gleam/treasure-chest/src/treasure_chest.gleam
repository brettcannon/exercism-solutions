pub type TreasureChest(a) {
  TreasureChest(String, a)
}

pub type UnlockResult(a) {
  Unlocked(a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    TreasureChest(p, treasure) if p == password -> Unlocked(treasure)
    _ -> WrongPassword
  }
}
