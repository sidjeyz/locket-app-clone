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
        #warning("А где презентер?")
            let validationResult = validateName(text)
        }
    }
    
    /// Валидирует имя на правильность
    /// - Parameter text: Текст для проверки
    /// - Returns: Да / нет
    private func validateName(_ text: String) -> Bool {
        
        if text.count >= 1 {
            return true
        } else {
            return false
        }
    }
}
extension NameSceneInteractor: NameSceneDataStore {
    
}
