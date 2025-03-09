//
//  RegNameViewController.swift
//  Locket
//
//  Created by Сулейман on 20.01.2025.
//

import Foundation
import UIKit

class RegistrationNameViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
                
        nameTextField.delegate = self
        let placeholder = "Имя"
        nameTextField.attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        nameTextField.text = UserDefaults.standard.name
        
        continueButton.layer.cornerRadius = 10
        continueButton.clipsToBounds = true
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor.secondaryLabel
        continueButton.setTitleColor(.systemGray, for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameTextField.text = ""
        
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func continueButton(_ sender: Any) {

            UserDefaults.standard.name = nameTextField.text

            
            let storyboard = UIStoryboard(name: "RegPasswordViewController", bundle: nil)
            if let regNameViewController = storyboard.instantiateViewController(withIdentifier: "RegPasswordViewController") as? RegPasswordViewController {
                navigationController?.pushViewController(regNameViewController, animated: true)
            } else {
                print("Не удалось найти RegPasswordViewController в Storyboard")
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
            
            nameTextField.resignFirstResponder()
            
        }
    
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    
    }
    
    
    
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
                if let text = nameTextField.text, !text.isEmpty || !string.isEmpty {
                    
                    continueButton.backgroundColor = UIColor.orange
                    continueButton.setTitleColor(.black, for: .normal)
                    continueButton.isEnabled = true
                    continueButton.setImage(UIImage(named: "continueBlack"), for: .normal)
                    
                } else {
                    
                    continueButton.backgroundColor = UIColor.secondaryLabel
                    continueButton.setTitleColor(.systemGray, for: .normal)
                    continueButton.isEnabled = false
                    
                }
                return true
        }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        
        nameTextField.text = ""
        
    }
    
}
