//
//  PhotoSceneFactory.swift
//  Locket
//
//  Created by sulik on 06.06.2025.
//

import UIKit

final class PhotoSceneFactory {
    
    func configure() -> UIViewController {
        let controller = PhotoSceneController(nibName: "PhotoSceneController", bundle: .main)
        let presenter = PhotoScenePresenter(controller: controller)
        let interactor = PhotoSceneInteractor(presenter: presenter)
        let router = PhotoSceneRouter(
            controller: controller,
            dataStore: interactor as! PhotoSceneDataStore
        )
        controller.interactor = interactor
        controller.router = router
        return controller
    }
}
