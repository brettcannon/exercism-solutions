import gleam/list
import gleam/string

const codon_length = 3

fn codon_split(str: String) -> List(String) {
  let codon = string.slice(str, at_index: 0, length: codon_length)
  let codon_length = string.length(codon)
  let rest_length = string.length(str) - codon_length
  let rest = string.slice(str, at_index: codon_length, length: rest_length)

  case codon {
    "" | "UAA" | "UAG" | "UGA" -> []
    codon if codon_length == 3 -> [codon, ..codon_split(rest)]
    _  -> [codon]
  }
}

fn translate(codon: String) -> Result(String, Nil) {
  case codon {
    "AUG" -> Ok("Methionine")
    "UUU" | "UUC" -> Ok("Phenylalanine")
    "UUA" | "UUG" -> Ok("Leucine")
    "UCU" | "UCC" | "UCA" | "UCG" -> Ok("Serine")
    "UAU" | "UAC" -> Ok("Tyrosine")
    "UGU" | "UGC" -> Ok("Cysteine")
    "UGG" -> Ok("Tryptophan")
    _  ->  Error(Nil)
  }
}

pub fn proteins(rna: String) -> Result(List(String), Nil) {
   rna |> codon_split |> list.try_map(translate)
}
