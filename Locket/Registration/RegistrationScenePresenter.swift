//
//  EmailScenePresentationLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


protocol RegistrationScenePresentationLogic: AnyObject {
    func buildState(response: RegistrationSceneModel.Response)
}

final class RegistationScenePresenter: RegistrationScenePresentationLogic {
    
    private weak var controller: RegistrationSceneDisplayLogic?
    
    init(controller: RegistrationSceneDisplayLogic) {
        self.controller = controller
    }
    
    func buildState(response: RegistrationSceneModel.Response) {
        switch response {
        
        case .start:
            controller?.displayContent(.display)
            
        case .adjustKeyboard(height: let height, duration: let duration):
            controller?.displayContent(.keyboardAdjustment(height: height, duration: duration))
            
        case .resetKeyboard:
            controller?.displayContent(.keyboardReset)
            
        case .moveToField(type: let type):
            controller?.displayContent(.updateField(type: type, isValid: false))
            controller?.displayContent(.scrollToField(type: type))
            
        case .validationResult(isValid: let isValid, type: let type):
            controller?.displayContent(.updateField(type: type, isValid: isValid))
            controller?.displayContent(.updateButtonState(isEnabled: isValid))
            
        }
    }
}


