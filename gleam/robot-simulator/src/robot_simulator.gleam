import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

type Instruction {
  Advance
  Rotate(rotate: Rotation)
}

type Rotation{
  Left
  Right
}

fn turn(robot: Robot, rotate: Rotation) -> Robot {
  let direction = case robot.direction, rotate {
    North, Left -> West
    North, Right -> East
    East, Left -> North
    East, Right -> South
    South, Left -> East
    South, Right -> West
    West, Left -> South
    West, Right -> North
  }

  Robot(..robot, direction:)
}

fn advance(robot: Robot) -> Robot {
  let Robot(direction, position) = robot
  let Position(x, y) = position
  let new_pos = case direction {
    North -> Position(x, y+1)
    East -> Position(x+1, y)
    South -> Position(x, y-1)
    West -> Position(x-1, y)
  }

  Robot(direction, new_pos)
}

fn dispatch(robot: Robot, instruction: Instruction) -> Robot {
  case instruction {
    Advance -> advance(robot)
    Rotate(rotate) -> turn(robot, rotate)
  }
}

fn decode(instruction: String) -> Instruction {
  case instruction {
    "A" -> Advance
    "L" -> Rotate(Left)
    "R" -> Rotate(Right)
    _ -> panic
  }
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  let start = Robot(direction, position)

  string.to_graphemes(instructions)  |> list.map(decode) |> list.fold(start, dispatch)
}
