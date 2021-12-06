//
//  Methods.swift
//  LanguageTraining
//
//  Created by Andrey Alymov on 06.12.2021.
//

import Foundation

//MARK: - Instance methods

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter() // the inital counter value is 0
counter.increment() // value is now 1
counter.increment(by: 4) // value is now 5
counter.reset() // value is now 0

//MARK: - The self property

class NewCounter {
    var count = 0
    func increment() {
        self.count += 1
    }
}

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1) {
    print("This point is to the right of the line where x == 1.0") // This point is to the right of the line where x == 1.0
}

//MARK: - Modyfying Value Types from Within Instance Methods

struct NewPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var someNewPoint = NewPoint(x: 1.0, y: 1.0)
someNewPoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at \(someNewPoint.x), \(someNewPoint.y)") // The point is now at 3.0, 4.0

let fixedPoint = NewPoint(x: 3.0, y: 3.0)
// fixedPoint.moveBy(x: 2.0, y: 3.0)  - this will report an error (let)

//MARK: - Assigning to self within a mutating method

struct ThatPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = ThatPoint(x: x + deltaX, y: y + deltaY)
    }
}

// Mutating methods for enumirations can set the implicit self parameter to be a different case from the same enumiration

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low // .low
ovenLight.next() // .high
ovenLight.next() // .off

//MARK: - Type methods

class SomeClass {
    class func someTypeMethod() {
        
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockLevel = 1
    var currentLevel = 0
    
    static func unlock(_ level: Int) {
        if level > highestUnlockLevel { highestUnlockLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Boboa")
player.complete(level: 1)
print("Highest unlocked level is now \(LevelTracker.highestUnlockLevel)")
// Highest unlocked level is now 2

player = Player(name: "Lili")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
// level 6 hasn't yet been unlocked

