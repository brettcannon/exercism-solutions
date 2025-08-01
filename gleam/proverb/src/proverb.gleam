import gleam/list
import gleam/string

fn line(pair: #(String, String)) -> String {
  let #(first, second) = pair

  "For want of a " <> first <> " the " <> second <> " was lost."
}

pub fn recite(inputs: List(String)) -> String {
  case list.first(inputs) {
    Error(_) -> ""
    Ok(first) -> {
      let pairs = list.window_by_2(inputs)
      let lines = list.map(pairs, line)

      list.append(lines, ["And all for the want of a "<> first <> "."]) |> string.join("\n")
    }
  }
}