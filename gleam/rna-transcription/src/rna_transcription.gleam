fn to_rna_acc(dna: String, acc: String) -> Result(String, Nil) {
  case dna {
    ""  -> Ok(acc)
    "G" <> rest -> to_rna_acc(rest, acc <> "C")
    "C" <> rest -> to_rna_acc(rest, acc <> "G")
    "T" <> rest -> to_rna_acc(rest, acc <> "A")
    "A" <> rest -> to_rna_acc(rest, acc <> "U")
    _ -> Error(Nil)
  }
}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  to_rna_acc(dna, "")
}
