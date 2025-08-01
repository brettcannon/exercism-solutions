import gleam/bit_array
import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

fn nucleotide_to_bitarray(n: Nucleotide) -> BitArray {
  let encoded = encode_nucleotide(n)
  <<encoded:2>>
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna |> list.map(nucleotide_to_bitarray) |> bit_array.concat
}

fn decode_bits(dna: BitArray, so_far: List(Nucleotide)) -> Result(List(Nucleotide), Nil) {
    case dna {
    <<>> -> Ok(so_far)
    <<n:2, rest:bits>> -> {
      let encoded = decode_nucleotide(n)
      case encoded {
        Ok(e) -> decode_bits(rest, list.append(so_far, [e]))
        Error(Nil) -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_bits(dna, [])
}
