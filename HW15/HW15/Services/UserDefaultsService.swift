//
//  UserDefaultsService.swift
//  HW15
//
//  Created by Вадим Игнатенко on 30.08.23.
//

import Foundation

final class UserDefaultsService {
    static func saveUserModel(userModel: UserModel) {
        UserDefaults.standard.set(userModel.name, forKey: UserDefaults.Keys.name.rawValue)
        UserDefaults.standard.set(userModel.email, forKey: UserDefaults.Keys.email.rawValue)
        UserDefaults.standard.set(userModel.pass, forKey: UserDefaults.Keys.password.rawValue)
    }

    static func setUserModel() -> UserModel? {
        let name = UserDefaults.standard.string(forKey: UserDefaults.Keys.name.rawValue)
        guard
            let email = UserDefaults.standard.string(forKey: UserDefaults.Keys.email.rawValue),
            let pass = UserDefaults.standard.string(forKey: UserDefaults.Keys.password.rawValue)
        else { return nil }
        let userModel = UserModel(name: name, email: email, pass: pass)
        return userModel
    }

    static func cleanUserDefaults() {
        UserDefaults.standard.reset()
    }
    
    static func changeUserModel (name: String?, email: String?, password: String?) {
        UserDefaults.standard.set(name, forKey: UserDefaults.Keys.name.rawValue)
        UserDefaults.standard.set(email, forKey: UserDefaults.Keys.email.rawValue)
        UserDefaults.standard.set(password, forKey: UserDefaults.Keys.password.rawValue)
    }
    
    
}
