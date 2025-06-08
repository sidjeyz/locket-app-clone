//
//  PhotoScenePresenter.swift
//  Locket
//
//  Created by sulik on 06.06.2025.
//

import Foundation

protocol PhotoScenePresentationLogic: AnyObject {
    func buildState(response: PhotoSceneModel.Response)
}

final class PhotoScenePresenter: PhotoScenePresentationLogic {
    
    private weak var controller: PhotoSceneDisplayLogic?
    
    init(controller: PhotoSceneDisplayLogic) {
        self.controller = controller
    }
    
    func buildState(response: PhotoSceneModel.Response) {
        switch response {
        case .start:
            self.controller?.displayContent(.display)
        }
        }
    }

