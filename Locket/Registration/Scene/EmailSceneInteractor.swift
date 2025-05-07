//
//  EmailSceneInteractor.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

protocol EmailSceneBusinessLogic: AnyObject {
	func makeState(request: EmailSceneModel.Request)
}

protocol EmailSceneDataStore {

}

final class EmailSceneInteractor: EmailSceneBusinessLogic {
    
    private var presenter: EmailScenePresentationLogic
    
    init(presenter: EmailScenePresentationLogic) {
        self.presenter = presenter
    }
	
	func makeState(request: EmailSceneModel.Request) {
		switch request {
		case .start:
			self.presenter.buildState(response: .start)
        case .emailTextDidChange(let text):
            let validationResult = validateEmail(text)
            self.presenter?.buildState(response: .emailDidChanged(validationResult))
		}
	}
    
    private func validateEmail(_ text: String) -> Bool {
        
    }
    
}

extension EmailSceneInteractor: EmailSceneDataStore {

}
