import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  name |> string.trim |> string.first |> result.unwrap("")
}

pub fn initial(name: String) {
  name |> first_letter |> string.uppercase |> string.append(".")
}

pub fn initials(full_name: String) {
  let assert Ok(#(first, last)) = full_name |> string.split_once(" ")

  initial(first) <> " " <> initial(last)
}

pub fn pair(full_name1: String, full_name2: String) {
"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> initials(full_name1) <> "  +  " <> initials(full_name2) <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
