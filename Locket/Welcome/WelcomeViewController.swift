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
        let storyboard = UIStoryboard(name: "RegistrationSceneController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegistrationSceneController") as! RegistrationSceneController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
