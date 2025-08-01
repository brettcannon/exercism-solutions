import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type School = dict.Dict(Int, List(String))

pub fn create() -> School {
  dict.new()
}

fn enrolled(school: School, student: String) -> Bool {
  dict.values(school) |> list.flatten |> list.contains(student)
}

pub fn roster(school: School) -> List(String) {
  let grades = dict.keys(school) |> list.sort(int.compare)

  grades |> list.flat_map(fn (key) {grade(school, key) |> list.sort(string.compare)})
}

pub fn add(
  to school: School,
  student student: String,
  grade grade_: Int,
) -> Result(School, Nil) {
  case enrolled(school, student) {
    True -> Error(Nil)
    False -> {
      let old_roster = grade(school, grade_)

      Ok(dict.insert(school, grade_, [student, ..old_roster]))
    } 
  }
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  dict.get(school, desired_grade) |> result.unwrap([])
}
