//
//  WelcomeViewController.swift
//  Locket
//
//  Created by Сулейман on 04.11.2024.
//

import Foundation
import UIKit



class WelcomeViewController: UIViewController{
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Task {
          //  try await client.test()
        //}
        
    }
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PhotoViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
