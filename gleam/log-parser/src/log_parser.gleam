import gleam/option.{Some}
import gleam/regex.{Match}

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) = regex.from_string("^\\[(DEBUG|INFO|WARNING|ERROR)\\]")
   re |> regex.check(line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regex.from_string("<[-~*=]*>")
  re |> regex.split(line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(re) = regex.from_string("User\\s+(\\S+)")

  case regex.scan(re, line) {
    [Match(_, [Some(user)])] -> "[USER] " <> user <> " " <> line
    _ -> line
  }
}
