//
//  Subsripts.swift
//  LanguageTraining
//
//  Created by Andrey Alymov on 08.12.2021.
//

import Foundation

// Subscript

//MARK: - Subscript sintax

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six multiply by three is equal \(threeTimesTable[6])") // six multiply by three is equal 18

//MARK: - Subscript usage

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

//MARK: - Subsript options

struct Matrix {
    
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, colums: Int) {
        self.rows = rows
        self.columns = colums
        grid = Array(repeating: 0.0, count: rows * colums)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, colums: 2)
print(matrix.grid) // [0.0, 0.0, 0.0, 0.0]
matrix[0, 1] = 1.5
print(matrix.grid) // [0.0, 1.5, 0.0, 0.0]
matrix[1, 0] = 3.2
print(matrix.grid) // [0.0, 1.5, 3.2, 0.0]
//let someValue = matrix[2, 2] - error Index out of range

//MARK: - Type subscript

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars) // mars
