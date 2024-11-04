//
//  RegistrationViewController.swift
//  Locket
//
//  Created by Сулейман on 23.10.2024.
//

import Foundation
import UIKit
class RegistrationViewController: UIViewController{
    
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.navigationItem.hidesBackButton = true
        
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        
        continueButton.isEnabled = false
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)

        
        }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

        self.emailTextField.becomeFirstResponder()
        
        }
    
    @objc func emailTextFieldEditingChanged(_ sender: UITextField) {

            if let email = sender.text, isValidEmail(email) {

                continueButton.backgroundColor = UIColor.orange
                continueButton.setTitleColor(.black, for: .normal)
                continueButton.isEnabled = true
                
            } else {
       
                continueButton.backgroundColor = UIColor.gray
                continueButton.isEnabled = false
                
            }
        }

    
    @objc func dismissKeyboard() {
        
            emailTextField.resignFirstResponder()
        
        }

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var continueLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func conditionsButton(_ sender: Any) {
        
        if let url = URL(string: "https://www.apple.com") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }

        }
    @IBAction func continueButton(_ sender: Any) {
        
        
        
        }
    func isValidEmail(_ email: String) -> Bool {
            // Простой регулярное выражение для проверки email
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }

}
