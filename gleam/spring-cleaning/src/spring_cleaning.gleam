import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(error) = problem

  error
}

pub fn remove_team_prefix(team: String) -> String {
  let assert Ok(#(_, name)) = string.split_once(team, "Team ")

  name
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert Ok(#(location, name)) = string.split_once(combined, ",")

  #(location, remove_team_prefix(name))
}