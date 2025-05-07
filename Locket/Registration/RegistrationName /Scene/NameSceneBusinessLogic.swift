//
//  EmailSceneBusinessLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


protocol NameSceneBusinessLogic: AnyObject {
    func makeState(request: NameSceneModel.Request)
}

protocol NameSceneDataStore {
    
}

final class NameSceneInteractor: NameSceneBusinessLogic {
    
    private var presenter: NameScenePresentationLogic
    
    init(presenter: NameScenePresentationLogic) {
        self.presenter = presenter
    }
    
    func makeState(request: NameSceneModel.Request) {
        switch request {
        case .start:
            print("Start request processed")
            presenter.buildState(response: .start)
            
        case .nameTextDidChange(let text):
            let validationResult = validateName(text)
        }
    }
    private func validateName(_ text: String) -> Bool {
        let nameTextField = NameSceneController().NameTextField
        let text = nameTextField?.text
        if text!.count >= 1 {
            return true
        } else {
            return false
        }
    }
}
extension NameSceneInteractor: NameSceneDataStore {
    
}
