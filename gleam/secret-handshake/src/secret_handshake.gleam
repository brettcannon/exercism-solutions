import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

fn wink(msg: Int) -> List(Command) {
  case int.bitwise_and(msg, 1) > 0 {
    True -> [Wink, ..double_blink(msg)]
    False -> double_blink(msg)
  }
}

fn double_blink(msg: Int) -> List(Command) {
  case int.bitwise_and(msg, 2) > 0 {
    True -> [DoubleBlink, ..close_your_eyes(msg)]
    False -> close_your_eyes(msg)
  }
}

fn close_your_eyes(msg: Int) -> List(Command) {
  case int.bitwise_and(msg, 4) > 0 {
    True -> [CloseYourEyes, ..jump(msg)]
    False -> jump(msg)
  }
}

fn jump(msg: Int) -> List(Command) {
  case int.bitwise_and(msg, 8) > 0 {
    True -> [Jump]
    False -> []
  }
}

pub fn commands(encoded_message: Int) -> List(Command) {
  case int.bitwise_and(encoded_message, 16) > 0 {
    True -> list.reverse(wink(encoded_message))
    False -> wink(encoded_message)
  }
}
