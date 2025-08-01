import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.0} /. 1.8
}

fn normalize(temp: Temperature) -> Float {
  case temp {
    Celsius(c) -> c
    Fahrenheit(f) -> fahrenheit_to_celsius(f)
  }
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  let left_in_c = normalize(left)
  let right_in_c = normalize(right)

  float.compare(left_in_c, right_in_c)
}

fn compare_cities(left: City, right: City) -> Order {
  let City(name: _, temperature: left_temp) = left
  let City(name: _, temperature: right_temp) = right

  compare_temperature(left_temp, right_temp)
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, compare_cities)
}
