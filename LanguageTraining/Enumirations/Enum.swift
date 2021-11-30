//
//  Enum.swift
//  LanguageTraining
//
//  Created by Andrey Alymov on 30.11.2021.
//

import Foundation

//MARK: - Sintax

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// or another view
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
directionToHead = .east

//MARK: - Using enumerations with a switch instruction

directionToHead = .south
switch directionToHead {
case .north:
    print("Brrrr")
case .south:
    print("Yahoooo")
case .east:
    print("Weeee")
case .west:
    print("PowPow")
}

// with default value

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Viable")
default:
    print("Not a safe area for humans")
}

//MARK: - Iterations by Enum cases (CaseIterable)

enum Beverage: CaseIterable {
    case coffe, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

//MARK: - Associative values

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 21234, 45512, 3)
productBarcode = .qrCode("ASDCSKNFRJWLDOF")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

//  switch productBarcode {
//  case let .upc(numberSystem, manufacturer, product, check):
//         .....
//  case let .qrCode(productCode)
//         ....
//  }

//MARK: - Source values

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//MARK: - Implicitly set initial values

enum PlanetInt: Int {
case mercury = 1, venus, earth, mars, jupiter, saturn
}

enum CompassPointStrings: String {
    case north, south, east, west
}

let earthsOrder = PlanetInt.earth.rawValue // earthsOrder equals 3
let sunsetDirection = CompassPointStrings.west.rawValue // sunsetDirection equals "west"

// Init with source value
let possiblePlanet = PlanetInt(rawValue: 6) // posPlanet has an optional type (PlanetInt?) and value is Planet.saturn

// 10 is out of range, and return nil
let positionToFind = 10
if let somePlanet = PlanetInt(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Good")
    default:
        print("Not good")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//MARK: - Recursive enums

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// for all cases
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression2.number(5)
let four = ArithmeticExpression2.number(4)
let sum = ArithmeticExpression2.addition(five, four)
let product = ArithmeticExpression2.multiplication(sum, ArithmeticExpression2.number(2))

// Recursive func
func evaluate(_ expression: ArithmeticExpression2) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product)) // 18
