import gleam/list
import gleam/string

const verses: List(String) = [
  "a Partridge in a Pear Tree",
  "two Turtle Doves",
  "three French Hens",
  "four Calling Birds",
  "five Gold Rings",
  "six Geese-a-Laying",
  "seven Swans-a-Swimming",
  "eight Maids-a-Milking",
  "nine Ladies Dancing",
  "ten Lords-a-Leaping",
  "eleven Pipers Piping",
  "twelve Drummers Drumming"
]

const day: List(String) = [
  "first",
  "second",
  "third",
  "fourth",
  "fifth",
  "sixth",
  "seventh",
  "eighth",
  "ninth",
  "tenth",
  "eleventh",
  "twelfth"
]

// Cheating by not checking the index range.
fn get(list_: List(String), at index: Int) -> String {
  case index, list_ {
    0, [item, ..] -> item
    _, [_, ..rest] -> get(rest, at: index-1)
    _, _ -> panic
  }
}

pub fn verse(number: Int) -> String {
  let day: String = get(day, at: number-1)
  let select_verses: List(String) = list.take(verses, number)

  // Cheating by assuming the number will never be out of range.
  let formatted_verses = case select_verses {
    [single] -> single
    [first, ..rest] -> {list.reverse(rest) |> string.join(", ")} <> ", and " <> first
    _ -> panic
  }

  "On the " <> day <> " day of Christmas my true love gave to me: " <> formatted_verses <> "."
}

pub fn lyrics(from starting_verse: Int, to ending_verse: Int) -> String {
  list.range(starting_verse, ending_verse) |> list.map(verse) |> string.join("\n")
}
