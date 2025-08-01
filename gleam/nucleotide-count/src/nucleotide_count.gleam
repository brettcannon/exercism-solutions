import gleam/dict.{type Dict}
import gleam/option
import gleam/string


fn increment(nucleotide: String, counts: Dict(String, Int)) -> Dict(String, Int) {
  dict.upsert(counts, nucleotide, fn (counts) {
    case counts {
      option.None -> 1
      option.Some(count) -> count + 1
    }
  })
}

fn count_nucleotides(dna: String, counts: Dict(String, Int)) -> Result(Dict(String, Int), Nil) {
  case string.pop_grapheme(dna) {
    Error(Nil) -> Ok(counts)
    Ok(#("A", rest)) -> count_nucleotides(rest, increment("A", counts))
    Ok(#("C", rest)) -> count_nucleotides(rest, increment("C", counts))
    Ok(#("G", rest)) -> count_nucleotides(rest, increment("G", counts))
    Ok(#("T", rest)) -> count_nucleotides(rest, increment("T", counts))
    _ -> Error(Nil)
  }
}

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  let zero_counts = dict.new() |> dict.insert("A", 0) |> dict.insert("C", 0) |> dict.insert("T", 0) |> dict.insert("G", 0)
  count_nucleotides(dna, zero_counts)
}
