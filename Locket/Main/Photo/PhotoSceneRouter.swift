//
//  PhotoSceneRouter.swift
//  Locket
//
//  Created by sulik on 06.06.2025.
//

import Foundation
import UIKit

protocol PhotoSceneRoutingLogic {

}

final class PhotoSceneRouter: PhotoSceneRoutingLogic {
    
    private weak var controller: UIViewController?
    private let dataStore: PhotoSceneDataStore
    
    init(controller: UIViewController, dataStore: PhotoSceneDataStore) {
        self.controller = controller
        self.dataStore = dataStore
    }
}
