import gleam/string

pub fn message(log_line: String) -> String {
  let assert Ok(#(_, msg)) = string.split_once(log_line, "]: ")

  string.trim(msg)
}

pub fn log_level(log_line: String) -> String {
  case string.split_once(log_line, "]: ") {
    Ok(#("[" <> level, _)) -> string.lowercase(level)
    _ -> panic as "malformed log line"
  }
}

pub fn reformat(log_line: String) -> String {
  let level = log_level(log_line)
  let msg = message(log_line)

  msg <> " (" <> level <> ")"
}
