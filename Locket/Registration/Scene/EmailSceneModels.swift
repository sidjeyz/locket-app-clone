//
//  EmailSceneModels.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//

import UIKit

enum EmailSceneModel {
	
    enum Request {
		case start
        case emailTextDidChange(String)
    }
    
    enum Response {
		case start
        case emailDidChanged(Bool)
    }
    
    enum ViewModel {
        
        struct ValidationResultViewModel {
            let buttonTExt: String
            let buttonTextColor: UIColor
            let buttonBackground: UIColor
        }
        
		case display
        case validationResult(ValidationResultViewModel)
        
       
    }

	enum Route {
		case route
	}

	enum Action {
		case action
	}
}
