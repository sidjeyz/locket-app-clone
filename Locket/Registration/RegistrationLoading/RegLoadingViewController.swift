//
//  RegLoadingViewController.swift
//  Locket
//
//  Created by Сулейман on 15.02.2025.
//

import Foundation
import UIKit
class RegLoadingViewController: UIViewController{
    
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Скрываем кнопку "Назад"
           self.navigationItem.hidesBackButton = true
       }

    
}
