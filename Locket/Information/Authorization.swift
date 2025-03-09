//
//  Authorization.swift
//  Locket
//
//  Created by Сулейман on 02.03.2025.
//

import Foundation


extension UserDefaults {
    var email: String? {
        get { return string(forKey: "email") }
        set { set(newValue, forKey: "email") }
    }
    
    var password: String? {
        get { return string(forKey: "password") }
        set { set(newValue, forKey: "password") }
    }
    
    var name: String? {
        get { return string(forKey: "name") }
        set { set(newValue, forKey: "name") }
    }
}
