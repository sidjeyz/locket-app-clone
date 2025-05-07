//
//  RegistrationEmailPresenter.swift
//  Locket
//
//  Created by Гусейн Римиханов on 14.04.2025.
//


import UIKit

class RegistrationEmailPresenter {
    
    var view: RegistrationEmailViewController!
    let service: RegistrantionService = .init()
    
    init(view: RegistrationEmailViewController!) {
        self.view = view
        
        self.view.viewModel = .init(mainTitle: "", emailPlaceholder: "", emailText: nil, termsText: <#T##NSAttributedString#>, button: <#T##RegistrationEmailViewModel.ButtonViewModel#>)
    }
    
    
    
    
}
