//
//  EmailSceneController.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

import UIKit
import MMCoreExtensions

protocol EmailSceneDisplayLogic: AnyObject {
	func requestRoute(_ route: EmailSceneModel.Route)
	func perfromAction(_ action: EmailSceneModel.Action)
	func displayContent(_ viewModel: EmailSceneModel.ViewModel)
}

final class EmailSceneController: UIViewController {
	
	var router: EmailSceneRoutingLogic?
	var interactor: EmailSceneBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.interactor?.makeState(request: .start)
    }
    
}

extension EmailSceneController: EmailSceneDisplayLogic {
    
	func displayContent(_ viewModel: EmailSceneModel.ViewModel) {
		switch viewModel {
		case .display:
			Task { @MainActor in

			}
        case .validationResult(let viewModel):
            Task { @MainActor
                
            }
		}
	}

	func requestRoute(_ route: EmailSceneModel.Route) {
		switch route {
		case .route:
			Task { @MainActor in

			}
		}
	}

	func perfromAction(_ action: EmailSceneModel.Action) {
		switch action {
		case .action:
			break
		}
	}
}
