//
//  EmailScenePresentationLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


protocol NameScenePresentationLogic: AnyObject {
    func buildState(response: NameSceneModel.Response)
}

final class NameScenePresenter: NameScenePresentationLogic {
    
    private weak var controller: NameSceneDisplayLogic?
    
    init(controller: NameSceneDisplayLogic) {
        self.controller = controller
    }
    
    func buildState(response: NameSceneModel.Response) {
        switch response {
        case .start:
            self.controller?.displayContent(.display)
        case .nameDidChandged(let result):
            let vm = NameSceneModel.ViewModel.ValidationViewModel(
                buttonIsEnabled: result,
                buttonBackgroundColor: result ? .orange : .gray,
                buttonTextColor: result ? .black : .darkGray)
            controller?.displayContent(.validationResult(vm))
        }
    }
}


