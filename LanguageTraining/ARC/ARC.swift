//
//  ARC.swift
//  LanguageTraining
//
//  Created by Andrey Alymov on 16.12.2021.
//

import Foundation

//MARK: - ARC in action

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
