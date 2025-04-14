//
//  EmailSceneRouter.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

import UIKit

protocol EmailSceneRoutingLogic {

}

final class EmailSceneRouter: EmailSceneRoutingLogic {
	
	private weak var controller: UIViewController?
	private let dataStore: EmailSceneDataStore
	
	init(controller: UIViewController, dataStore: EmailSceneDataStore) {
		self.controller = controller
		self.dataStore = dataStore
	}
}
