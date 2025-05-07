//
//  EmailSceneFactory.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

import UIKit

final class EmailSceneFactory {
	
	func configure() -> UIViewController {
		let controller = EmailSceneController(nibName: "EmailSceneController", bundle: <#T##Bundle?#>)
		let presenter = EmailScenePresenter(controller: controller)
		let interactor = EmailSceneInteractor(presenter: presenter)
		let router = EmailSceneRouter(
			controller: controller,
			dataStore: interactor
		)
		controller.interactor = interactor
		controller.router = router
		return controller
	}
}
