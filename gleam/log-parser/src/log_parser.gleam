import gleam/option.{Some}
import gleam/regexp.{Match}

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) = regexp.from_string("^\\[(DEBUG|INFO|WARNING|ERROR)\\]")
   re |> regexp.check(line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regexp.from_string("<[-~*=]*>")
  re |> regexp.split(line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(re) = regexp.from_string("User\\s+(\\S+)")

  case regexp.scan(re, line) {
    [Match(_, [Some(user)])] -> "[USER] " <> user <> " " <> line
    _ -> line
  }
}
