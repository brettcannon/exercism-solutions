import gleam/int
import gleam/list

// Please define the Usd type
pub type Usd {
  Usd
}

// Please define the Eur type
pub type Eur {
  Eur
}

// Please define the Jpy type
pub type Jpy {
  Jpy
}

// Please define the Money type
pub opaque type Money(currency) {
  Money(amount: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  Money(amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  Money(amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  Money(amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  list.fold(prices, Money(0), fn(x: Money(currency), y: Money(currency)) {Money(x.amount + y.amount)})
}
