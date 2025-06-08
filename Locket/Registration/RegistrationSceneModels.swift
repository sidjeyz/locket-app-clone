//
//  EmailSceneModel.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit

enum RegistrationSceneModel {
    
    enum Request {
        
        case start
        case keyboardWillShow(height: CGFloat, duration: Double)
        case keyboardWillHide
        case dismissKeyboard
        case validateField(text: String, type: FieldType)
        case proceedToNextField
        case returToPreviousField
        
    }
    
    enum Response {
        
        case start
        case adjustKeyboard(height: CGFloat, duration: Double)
        case resetKeyboard
        case moveToField(type: FieldType)
        case validationResult(isValid: Bool, type: FieldType)
        
    }
    
    enum ViewModel {
        
        case display
        case keyboardAdjustment(height: CGFloat, duration: Double)
        case keyboardReset
        case updateButtonState(isEnabled: Bool)
        case updateField(type: FieldType, isValid: Bool)
        case scrollToField(type: FieldType)
    }
    
    enum FieldType: CaseIterable{
        
        case email
        case nickname
        case name
        case password
        
        var next: FieldType? {
            let all = Self.allCases
            guard let index = all.firstIndex(of: self) else { return nil }
            return all[safe: index + 1]
        }
        
        var previous: FieldType? { // Добавлено
            let all = Self.allCases
            guard let index = all.firstIndex(of: self) else { return nil }
            return all[safe: index - 1]
        }
    }
    
    enum Route {
        case route
    }
    
    enum Action {
        case action
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
