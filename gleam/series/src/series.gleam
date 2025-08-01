import gleam/string

pub type Error {
  SliceLengthTooLarge
  SliceLengthZero
  SliceLengthNegative
  EmptySeries
}

fn window(input: String, start: Int, size: Int) -> List(String) {
  case string.length(input) >= start + size {
    False -> []
    True -> [string.slice(input, start, size), ..window(input, start+1, size)]
  }
}

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let input_length = string.length(input)

  case size {
    _ if input_length == 0 -> Error(EmptySeries)
    _ if size > input_length -> Error(SliceLengthTooLarge)
    _ if size == 0 -> Error(SliceLengthZero)
    _ if size < 0 -> Error(SliceLengthNegative)
    _ -> Ok(window(input, 0, size))
  }
}
