//
//  EmailSceneFactory.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit

final class RegistrationSceneFactory {
	
	func configure() -> UIViewController {
        let controller = RegistrationSceneController(nibName: "RegistrationSceneController", bundle: .main)
        let presenter = RegistationScenePresenter(controller: controller)
        let interactor = RegistrationSceneInteractor(presenter: presenter)
        let router = RegistrationSceneRouter(
            controller: controller,
            dataStore: interactor
        )
        controller.interactor = interactor
        controller.router = router
        return controller
	}
}
