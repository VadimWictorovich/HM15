//
//  VerificationService.swift
//  HW15
//
//  Created by Вадим Игнатенко on 28.08.23.
//

import Foundation


enum PasswordStrength: Int {
    case veryWeak
    case weak
    case notVeryWeak
    case notVeryStrong
    case srtong
}


final class VerificationService {

    static let weakRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let notVeryWeakRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
    static let notVeryStrongRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    static let strongRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    
     static func isValidPassword (pass: String) -> PasswordStrength {
         if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: pass) {
             return .srtong
         } else if NSPredicate(format: "SELF MATCHES %@", notVeryStrongRegex).evaluate(with: pass) {
             return .notVeryStrong
         } else if NSPredicate(format: "SELF MATCHES %@", notVeryWeakRegex).evaluate(with: pass) {
             return .notVeryWeak
         } else if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: pass) {
             return .weak
         } else {
             return .veryWeak
         }
     }
    
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isPassConf(pass1: String, pass2: String) -> Bool {
        pass1 == pass2
    }
}
