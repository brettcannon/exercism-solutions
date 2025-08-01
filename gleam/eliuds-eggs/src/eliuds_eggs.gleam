fn egg_count_bits(eggs: BitArray) -> Int {
  case eggs {
    <<1:size(1), rest:bits>> -> 1 + egg_count_bits(rest)
    <<0:size(1), rest:bits>> -> egg_count_bits(rest)
    _ -> 0
  }
}

pub fn egg_count(number: Int) -> Int {
  egg_count_bits(<<number:size(64)>>)
}
