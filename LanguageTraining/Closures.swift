//
//  main.swift
//  LanguageTraining
//
//  Created by Andrey Alymov on 24.11.2021.
//

import Foundation

//MARK: - Function for increasing array elements +

var arry = [2, 3, 4, 5]

func increment(by number: Int, to array: [Int]) -> [Int] {
    var newArr: [Int] = []
    for i in array {
        newArr.append(number + i)
    }
    return newArr
}

let newArray = increment(by: 2, to: arry)

//MARK: - Function for increasing array elements

func square(_ array: [Int]) -> [Int] {
    var newArr: [Int] = []
    for i in array {
        newArr.append(i * i)
    }
    return newArr
}

//MARK: - Transform parameter is closure (only Int)

func myMapp(for array: [Int], _ transform: (Int) -> Int) -> [Int] {
    var newArr: [Int] = []
    for i in array {
        newArr.append(transform(i))
    }
    return newArr
}

let result1 = myMapp(for: arry) { $0 + 2 }
let result2 = myMapp(for: arry) { $0 * $0 }

//MARK: - Transform parameter is closure (input only Int, output generic T)

func myUniqMap<T>(for array: [Int], _ transform: (Int) -> T) -> [T] {
    var newArr: [T] = []
    for i in array {
        newArr.append(transform(i))
    }
    return newArr
}

let result3 = myUniqMap(for: arry) { String($0) }

//MARK: - Full generic function with extenstion is method for Array type

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var newArr: [T] = []
        for element in self {
            newArr.append(transform(element))
        }
        return newArr
    }
}

