import gleam/list
import gleam/string

const verses = [
  "the horse and the hound and the horn that belonged to",
  "the farmer sowing his corn that kept",
  "the rooster that crowed in the morn that woke",
  "the priest all shaven and shorn that married",
  "the man all tattered and torn that kissed",
  "the maiden all forlorn that milked",
  "the cow with the crumpled horn that tossed",
  "the dog that worried",
  "the cat that killed",
  "the rat that ate",
  "the malt that lay in",
  "the house that Jack built"
]

const verses_count = 12  // list.length(verses)

fn recite_from_verse(line: Int) -> String {
  let #(_, verses_to_use) = list.split(verses,  verses_count - line)

  "This is " <> string.join(verses_to_use, with: " ") <> "."
}

pub fn recite(start_verse start_verse: Int, end_verse end_verse: Int) -> String {
  list.range(start_verse, end_verse) |> list.map(recite_from_verse) |> string.join("\n")
}
