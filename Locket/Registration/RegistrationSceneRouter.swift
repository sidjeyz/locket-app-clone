//
//  EmailSceneRoutingLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit

protocol RegistrationSceneRoutingLogic {
    
}

final class RegistrationSceneRouter: RegistrationSceneRoutingLogic {
    
    private weak var controller: UIViewController?
    private let dataStore: RegistrationSceneDataStore
    
    init(controller: UIViewController, dataStore: RegistrationSceneDataStore) {
        self.controller = controller
        self.dataStore = dataStore
    }
}
