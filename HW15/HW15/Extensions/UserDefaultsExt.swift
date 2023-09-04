//
//  UserDefaultsExt.swift
//  HW15
//
//  Created by Вадим Игнатенко on 30.08.23.
//

import Foundation


extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case name
        case email
        case password
    }
    
    func reset() {
        let allCases = Keys.allCases
        allCases.forEach { removeObject(forKey: $0.rawValue)
        }
    }
}
