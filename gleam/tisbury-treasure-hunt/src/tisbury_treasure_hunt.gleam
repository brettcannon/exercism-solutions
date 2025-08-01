import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(letter, number) = place_location

  #(number, letter)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let #(_, place_location) = place
  let treasure_location = place_location_to_treasure_location(place_location)

  list.count(treasures, fn (t) {
    let #(_, t_location) = t
    treasure_location == t_location
  })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  let #(found, _) = found_treasure
  let #(location, _) = place
  let #(desired, _) = desired_treasure

  case found {
    "Brass Spyglass" if location == "Abandoned Lighthouse" -> True
    "Amethyst Octopus" if location == "Stormy Breakwater" && {desired == "Crystal Crab" || desired == "Glass Starfish"} -> True
    "Vintage Pirate Hat" if location == "Harbor Managers Office" && {desired == "Model Ship in Large Bottle" || desired == "Antique Glass Fishnet Float"} -> True
    _ -> False
  }
}
