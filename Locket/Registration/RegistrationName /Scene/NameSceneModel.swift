//
//  EmailSceneModel.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit

enum NameSceneModel {
    
    enum Request {
        case start
        case nameTextDidChange(String)
    }
    
    enum Response {
        case start
        case nameDidChandged(Bool)
    }
    
    enum ViewModel {
        case display
        struct ValidationViewModel {
            let buttonIsEnabled: Bool
            let buttonBackgroundColor: UIColor
            let buttonTextColor: UIColor
        }
        case validationResult(ValidationViewModel)
    }
    
    enum Route {
        case passwordScreen(name: String)
    }
    
    enum Action {
        case start
        case showKeyboard(height: CGFloat, duration: Double)
        case hideKeyboard
    }
}
