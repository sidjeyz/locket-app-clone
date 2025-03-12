//
//  RegistrationPassword.swift
//  Locket
//
//  Created by Сулейман on 20.01.2025.
//

import Foundation
import UIKit

class RegPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordTextView: UITextView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        let placeholder = ""
        passwordTextField.attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        
        continueButton.layer.cornerRadius = 10
        continueButton.clipsToBounds = true
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor.secondaryLabel
        continueButton.setTitleColor(.systemGray, for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordTextField.text = ""
        
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func continueButton(_ sender: Any) {
            
        Authorization.shared.password = passwordTextField.text
        
            let storyboard = UIStoryboard(name: "RegLoadingViewController", bundle: nil)
            if let regNameViewController = storyboard.instantiateViewController(withIdentifier: "RegLoadingViewController") as? RegLoadingViewController {
                navigationController?.pushViewController(regNameViewController, animated: true)
            } else {
                
                print("Не удалось найти RegLoadingViewController в Storyboard")
                
            }
            
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            let isPasswordValid = isValidPassword(updatedText)
            updateContinueButtonState(isEnabled: isPasswordValid)
            return true
        
        }

        func isValidPassword(_ password: String) -> Bool {
            let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
            let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
            let isLongEnough = password.count >= 8 
            return hasUppercase && hasNumber && isLongEnough
        }

        private func updateContinueButtonState(isEnabled: Bool) {
            if isEnabled {
                continueButton.backgroundColor = UIColor.orange
                continueButton.setTitleColor(.black, for: .normal)
                continueButton.isEnabled = true
                continueButton.setImage(UIImage(named: "continueBlack"), for: .normal)
                
            } else {
                continueButton.backgroundColor = UIColor.secondaryLabel
                continueButton.setTitleColor(.systemGray, for: .normal)
                continueButton.isEnabled = false
                continueButton.setImage(UIImage(named: "continue"), for: .normal)
                
            }
        }


    
    private func moveTermsTextView(isUpwards: Bool, keyboardHeight: CGFloat, duration: Double) {
        
        let bottomPadding = self.view.safeAreaInsets.bottom
        
        print(bottomPadding)
        
        self.buttonBottomConstraint.constant = isUpwards ? (keyboardHeight - bottomPadding + 22) : 0
   
        
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut, animations: {
            self.view.layoutIfNeeded()
        })
        animator.startAnimation()
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        {
            moveTermsTextView(isUpwards: true, keyboardHeight: keyboardSize.height, duration: duration)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                moveTermsTextView(isUpwards: false, keyboardHeight: keyboardSize.height, duration: 0)
            }
        }
    
    @objc func dismissKeyboard() {
            
            passwordTextField.resignFirstResponder()
            
        }
    
    
}
