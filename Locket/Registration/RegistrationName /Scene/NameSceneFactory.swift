//
//  EmailSceneFactory.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit

final class NameSceneFactory {
	
	func configure() -> UIViewController {
        let controller = NameSceneController(nibName: "NameSceneController", bundle: .main)
        let presenter = NameScenePresenter(controller: controller as! NameSceneDisplayLogic)
		let interactor = NameSceneInteractor(presenter: presenter)
		let router = NameSceneRouter(
			controller: controller,
			dataStore: interactor
		)
		controller.interactor = interactor
        controller.router = router as any NameSceneRoutingLogic
		return controller
	}
}
