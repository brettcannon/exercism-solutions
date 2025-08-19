import gleam/int
import gleam/string

pub type Clock {
  Clock(span: Int)
}

const day = 1440  // 24 * 60

fn to_minutes(hours: Int) -> Int {
  hours * 60
}

fn from_minutes(minutes: Int) -> Clock {
  let assert Ok(span) = int.modulo(minutes, day)

  Clock(span)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  let raw_span = to_minutes(hour) + minute

  from_minutes(raw_span)
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  from_minutes(clock.span + minutes)
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  from_minutes(clock.span - minutes)
}

fn to_string(num: Int) -> String {
  num |> int.to_string |> string.pad_start(to: 2, with: "0")
}

pub fn display(clock: Clock) -> String {
  let assert Ok(hours) = int.floor_divide(clock.span, 60)
  let minutes = clock.span - to_minutes(hours)
  to_string(hours) <> ":" <> to_string(minutes)
}
