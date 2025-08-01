import gleam/string


fn orphaned_pairs(value: String, openers: List(String)) -> Bool {
  case string.pop_grapheme(value), openers {
    Error(_), [] -> True
    Error(_), _ -> False
    Ok(#(opener, rest)), _ if opener == "[" || opener == "{" || opener == "(" -> orphaned_pairs(rest, [opener, ..openers])
    Ok(#("]", rest)), ["[", ..rest_openers] -> orphaned_pairs(rest, rest_openers)
    Ok(#("]", _)), _ -> False
    Ok(#("}", rest)), ["{", ..rest_openers] -> orphaned_pairs(rest, rest_openers)
    Ok(#("}", _)), _ -> False
    Ok(#(")", rest)), ["(", ..rest_openers] -> orphaned_pairs(rest, rest_openers)
    Ok(#(")", _)), _ -> False
    Ok(#(_, rest)), _ -> orphaned_pairs(rest, openers)
  }
}

pub fn is_paired(value: String) -> Bool {
  orphaned_pairs(value, [])
}
