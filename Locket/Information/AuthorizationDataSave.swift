//
//  DataSave.swift
//  Locket
//
//  Created by Сулейман on 09.03.2025.
//

import Foundation
import UIKit

protocol AutorizationService{
    
    func save(authorization: Authorization) throws
    func extractData() -> [Authorization]
    
}


class AuthorizationImpl: AutorizationService{
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func save(authorization: Authorization) throws {
        let ud = UserDefaults.standard
        print(ud.object(forKey: Constants.authorizationKey))
        if let currentData = ud.object(forKey: Constants.authorizationKey) as? Data{
            var auhorizations = try decoder.decode([Authorization].self, from: currentData)
            auhorizations.append(authorization)
            let updatedAuthorizationsData = try encoder.encode(auhorizations)
            ud.set(updatedAuthorizationsData, forKey: Constants.authorizationKey)
        } else {
            let authorizations = [Authorization]()
            let data = try encoder.encode(authorizations)
            ud.set(data, forKey: Constants.authorizationKey)
        }
    }
    
    func extractData() -> [Authorization]{
        let ud = UserDefaults.standard
        var authorizations = [Authorization]()
        if let currentData = ud.object(forKey: Constants.authorizationKey), let authorization = try? decoder.decode([Authorization].self, from: currentData as! Data) {
            authorizations = authorization
            
        }
        return authorizations
    }
    
    
}
func testAuthorizationService() {
    
    let authorizationService = AuthorizationImpl()
    
    do {
        let auth1 = Authorization(email: Authorization.shared.email, password: Authorization.shared.password, name: Authorization.shared.name)
        
        
        // Сохраняем авторизации
        try authorizationService.save(authorization: auth1)
        
        // Извлекаем авторизации
        let extractedAuthorizations = authorizationService.extractData()
        
        // Проверяем результат
        print("Final extracted authorizations:", extractedAuthorizations)
    } catch {
        print("Error while saving or extracting data:", error)
    }
}

