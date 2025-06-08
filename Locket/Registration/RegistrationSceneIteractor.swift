//
//  EmailSceneBusinessLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//

import Foundation


protocol RegistrationSceneBusinessLogic: AnyObject {
    func makeState(request: RegistrationSceneModel.Request)
}

protocol RegistrationSceneDataStore {
    
}

final class RegistrationSceneInteractor: RegistrationSceneBusinessLogic {
    
    private var presenter: RegistrationScenePresentationLogic
    private var currentField: RegistrationSceneModel.FieldType = .email
    private var fieldsData: [RegistrationSceneModel.FieldType: String] = [:]
    
    init(presenter: RegistrationScenePresentationLogic) {
        self.presenter = presenter
    }
    
    func makeState(request: RegistrationSceneModel.Request) {
        switch request {
        case .start:
            self.presenter.buildState(response: .start)
        case .keyboardWillShow(height: let height, duration: let duration):
            presenter.buildState(response: .adjustKeyboard(height: height, duration: duration))
        case .keyboardWillHide:
            presenter.buildState(response: .resetKeyboard)
        case .dismissKeyboard:
            break
        case .validateField(text: let text, type: let type):
            fieldsData[type] = text
            let isValid = validate(text, for: type)
            presenter.buildState(response: .validationResult(isValid: isValid, type: type))
        case .proceedToNextField:
            guard let nextField = currentField.next else { return }
            currentField = nextField
            presenter.buildState(response: .moveToField(type: nextField))
        case .returToPreviousField:
            guard let previousField = currentField.previous else { return }
                    currentField = previousField
                    presenter.buildState(response: .moveToField(type: previousField))
        }
        
        
    }
    private func validate(_ text: String, for fieldType: RegistrationSceneModel.FieldType) -> Bool {
        switch fieldType {
        case .email:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
        case .nickname:
            let regex = "^[a-zA-Z0-9_]*$"
            return text.range(of: regex, options: .regularExpression) != nil
        case .name:
            if text.count >= 1 {
                        return true
                    } else {
                        return false
                    }
        case .password:
            let hasUppercase = text.rangeOfCharacter(from: .uppercaseLetters) != nil
            let hasNumber = text.rangeOfCharacter(from: .decimalDigits) != nil
            let isLongEnough = text.count >= 8
            return hasUppercase && hasNumber && isLongEnough
        }
    }
}
extension RegistrationSceneInteractor: RegistrationSceneDataStore {
    
}
