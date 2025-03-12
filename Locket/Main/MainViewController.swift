//
//  MainViewController.swift
//  Locket
//
//  Created by Сулейман on 05.03.2025.
//

import Foundation
import UIKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var photoView: UIView!
    
    override func viewDidLayoutSubviews() {
        
        self.mainScrollView.setContentOffset(CGPoint(x: self.view.bounds.width, y: 0), animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Скрываем кнопку "Назад"
        self.navigationItem.hidesBackButton = true
        
        let storyboard = UIStoryboard(name: "PhotoViewController", bundle: nil)
        if let photoVC = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController  {
            
            photoView.addSubview(photoVC.view)
            self.addChild(photoVC)
            
        } else {
            
            print("Не удалось найти PhotoViewController  в Storyboard")
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
}
