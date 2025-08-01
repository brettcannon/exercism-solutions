pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    41 | 43 -> "So close"
    x if x < 41 -> "Too low"
    _ -> "Too high"  // Same as `x if x > 43`.
  }
}
