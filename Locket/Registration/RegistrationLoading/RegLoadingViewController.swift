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
    
    override func viewDidLoad() {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loading.stopAnimating()
            
            let storyboard = UIStoryboard(name: "MainViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
}
