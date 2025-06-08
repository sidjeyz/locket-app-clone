//
//  PhotoSceneInteractor.swift
//  Locket
//
//  Created by sulik on 06.06.2025.
//

import Foundation
import AVFoundation
import UIKit



protocol PhotoSceneBusinessLogic: AnyObject {
    func makeState(request: PhotoSceneModel.Request)
}

protocol PhotoSceneDataStore {
}

final class PhotoSceneInteractor: PhotoSceneBusinessLogic {
    private var presenter: PhotoScenePresentationLogic
    
    init(presenter: PhotoScenePresentationLogic) {
        self.presenter = presenter
    }
    
    func makeState(request: PhotoSceneModel.Request) {
        switch request {
        case .start:
            self.presenter.buildState(response: .start)
            
        }
    }
}
extension PhotoSceneInteractor: PhotoSceneDataStore {
    
}
