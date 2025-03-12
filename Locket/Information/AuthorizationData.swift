//
//  Authorization.swift
//  Locket
//
//  Created by Сулейман on 02.03.2025.
//

import Foundation

struct Authorization: Codable{
    
    static var shared = Authorization()
    var email: String?
    var password: String?
    var name: String?
    
}
struct AuthorizationModel{
    
    var email: String?
    var name: String?
    var password: String?
    
    func getAuthorization() -> Authorization? {
        
        guard let email, let name, let password else{return nil}
        return Authorization(email: email, password: password, name: name)
        
    }
    
    func saveToShared() {
            Authorization.shared.email = email
            Authorization.shared.name = name
            Authorization.shared.password = password
        }

}
