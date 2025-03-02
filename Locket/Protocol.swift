//
//  Protocol.swift
//  Locket
//
//  Created by Сулейман on 02.03.2025.
//

import Foundation
import UIKit

    
protocol RegistrationDelegate: AnyObject {
    
    func didFinishRegistration(authorization: Authorization)
    
}
    
