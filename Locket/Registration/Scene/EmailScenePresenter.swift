//
//  EmailScenePresenter.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

protocol EmailScenePresentationLogic: AnyObject {
	func buildState(response: EmailSceneModel.Response)
}

final class EmailScenePresenter: EmailScenePresentationLogic {
    
	private weak var controller: EmailSceneDisplayLogic?
    
    init(controller: EmailSceneDisplayLogic) {
        self.controller = controller
    }
    
	func buildState(response: EmailSceneModel.Response) {
		switch response {
		case .start:
			self.controller?.displayContent(.display)
        case .emailDidChanged(let result):
            let vm = EmailSceneModel.ViewModel.ValidationResultViewModel(buttonTExt: "Продолжить",
                                                                         buttonTextColor: result ? .black : .systemGray2,
                                                                         buttonBackground: result ? .orange : .gray)
            controller?.displayContent(.validationResult(vm))
            
		}
	}
}
