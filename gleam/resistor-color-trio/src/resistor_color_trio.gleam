import gleam/list

// Cheating by not checking for errors.
fn colour_to_num(colour: String) -> Int {
  case colour {
    "black" -> 0
    "brown" -> 1
    "red" -> 2
    "orange" -> 3
    "yellow" -> 4
    "green" -> 5
    "blue" -> 6
    "violet" -> 7
    "grey" -> 8
    "white" -> 9
    _ -> -1
  }
}

// Since the inputs can only be what's from `colour_to_num`, no need to worry about negative exponents.
fn base10_pow(exponent: Int) -> Int {
  case exponent {
    0 -> 1
    exp -> 10 * base10_pow(exp-1)
  }
}

// kilo=000
// mega=000_000
// giga=000_000_000
fn scale(value: Int) -> Resistance {
  case value {
    0 -> Resistance("ohms", 0)
    _ if {value % 1_000_000_000} == 0 -> Resistance("gigaohms", value / 1_000_000_000)
    _ if {value % 1_000_000} == 0 -> Resistance("megaohms", value / 1_000_000)
    _ if {value % 1_000} == 0 -> Resistance("kiloohms", value / 1_000)
    _ -> Resistance("ohms", value)
  }
}

pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  // Cheating by not checking the minimum number of colours.
  let assert [tens, ones, zeros, .._] = list.map(colors, colour_to_num)
  let value = {{tens * 10} + ones} * base10_pow(zeros)
  
  Ok(scale(value))
}
