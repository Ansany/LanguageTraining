//
//  Properties.swift
//  LanguageTraining
//
//  Created by Andrey Alymov on 01.12.2021.
//

import Foundation

// Properties
//MARK: - Stored properties

struct FixedLenghtRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLenghtRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//MARK: - Stored properties of constant struct instances

let rangeOfFourItems = FixedLenghtRange(firstValue: 0, length: 4)
// rangeOfFourItems.firstValue = 6 - this code will not compile

//MARK: - Lazy stored properties

class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter() // its laze property
    var data: [String] = []
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created

print(manager.importer.fileName) // the DataImporter instance for the importer property has now created

//MARK: - Computed properties

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, hight = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.hight / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.hight / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, hight: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// square.origin is now at (10.0, 10.0)

//MARK: - Shorthand setter declaration

struct AlternativeRect  {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.hight / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.hight / 2)
        }
    }
}

//MARK: - Shorthand getter declaration

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.hight / 2))
            // If the entire body of a getter is a single expression, the getter implicitly returns that expression.
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.hight / 2)
        }
    }
}

//MARK: - Read-Only computed properties (without setter)

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// the volume of fourByFiveByTwo is 40.0

//MARK: - Property observers (willSet, didSet)

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCoounter = StepCounter()
stepCoounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCoounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps

//MARK: - Property wrappers

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) } //new values are less than 12
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height) // 0

rectangle.height = 10
print(rectangle.height) // 10

rectangle.height = 24
print(rectangle.height) // 12

struct SmallRectangle2 {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

//MARK: - Setting initial values for wrapped properties

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum)}
    }
    
    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

// 1
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width) // 0 0

// 2
struct UnitRectangle {
    @SmallNumber var height = 1
    @SmallNumber var width = 1
}
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width) // 1 1

// 3
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var heigth: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.heigth, narrowRectangle.width) // 2 3
narrowRectangle.heigth = 100
narrowRectangle.width = 100
print(narrowRectangle.heigth, narrowRectangle.width) // 5 4

// 4
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}
var mixedRectangle = MixedRectangle()
print(mixedRectangle.height) // 1
mixedRectangle.height = 20
print(mixedRectangle.height) // 12

//MARK: - Projecting a value from a property wrapper

@propertyWrapper
struct SmallNumber2 {
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStruct {
    @SmallNumber2 var someNumber: Int
}
var someStruct = SomeStruct()
someStruct.someNumber = 4
print(someStruct.$someNumber) // false

someStruct.someNumber = 55
print(someStruct.$someNumber) // true

// Enum
enum Size2 {
    case small, large
}

struct SizeRectangle {
    @SmallNumber2 var height: Int
    @SmallNumber2 var width: Int
    
    mutating func resize(to size: Size2) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}

//MARK: - Type property syntax

struct SomeNewStruct {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeNewClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedProperty: Int {
        return 107
    }
}

//MARK: - Querying and settings type properties

print(SomeNewStruct.storedTypeProperty) // Some value
SomeNewStruct.storedTypeProperty = "Another value"
print(SomeNewStruct.storedTypeProperty) // Another value
print(SomeEnum.computedTypeProperty) // 6
print(SomeNewClass.computedTypeProperty) // 27

struct AudioChannel {
    static let thresholderLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholderLevel {
                currentLevel = AudioChannel.thresholderLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

// create an initial of AudioChannel
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel) // 7
print(AudioChannel.maxInputLevelForAllChannels) // 7
rightChannel.currentLevel = 11
print(rightChannel.currentLevel) // 10
print(AudioChannel.maxInputLevelForAllChannels) // 10


