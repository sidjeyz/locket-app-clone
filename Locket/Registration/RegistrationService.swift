//
//  RgistrationService.swift
//  Locket
//
//  Created by sulik on 02.06.2025.
//

import Foundation

final class RegistrantionService {
    
    
     func validateEmail(_ text: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
    }

     func validateNickname(_ text: String) -> Bool {
        let regex = "^[a-zA-Z0-9_]*$"
        return text.range(of: regex, options: .regularExpression) != nil
    }

     func validateName(_ text: String) -> Bool {
        return text.count >= 1
    }

     func validatePassword(_ text: String) -> Bool {
        let hasUppercase = text.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasNumber = text.rangeOfCharacter(from: .decimalDigits) != nil
        let isLongEnough = text.count >= 8
        return hasUppercase && hasNumber && isLongEnough
    }
    
}
