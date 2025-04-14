//
//  RegistrantionService.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

import Foundation

final class RegistrantionService {
    
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}
