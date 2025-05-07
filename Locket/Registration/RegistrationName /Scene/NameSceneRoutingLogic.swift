//
//  EmailSceneRoutingLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit

protocol NameSceneRoutingLogic {
    func routeTo(route: NameSceneModel.Route)
}

final class NameSceneRouter: NameSceneRoutingLogic {
    
    private weak var controller: UIViewController?
    private let dataStore: NameSceneDataStore
    
    init(controller: UIViewController, dataStore: NameSceneDataStore) {
        self.controller = controller
        self.dataStore = dataStore
    }
    func routeTo(route: NameSceneModel.Route) {
        switch route {
        case .passwordScreen(let name):
            let storyboard = UIStoryboard(name: "RegPasswordViewController", bundle: nil)
            let regNameViewController = storyboard.instantiateViewController(withIdentifier: "RegPasswordViewController") as? RegPasswordViewController
        }
    }
}
