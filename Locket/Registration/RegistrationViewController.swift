//
//  RegistrationViewController.swift
//  Locket
//
//  Created by Сулейман on 23.10.2024.
//

import Foundation
import UIKit
class RegistrationViewController: UIViewController{
    
    
    @IBOutlet weak var termsTextView: UITextView!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        self.navigationItem.hidesBackButton = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        continueButton.isEnabled = false
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)
        
        
    }
    
    private func setup() {
        // "Нажимая продолжить, вы соглашаетесь с  условиями сервиса"
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = 8
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .paragraphStyle: style
        ]
        
        var termsText = NSMutableAttributedString(string: "Нажимая продолжить, вы соглашаетесь с ", attributes: attributes)
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .link: URL(string: "https://apple.com")!
        ]
        
        let linkText = NSAttributedString(string: "условиями сервиса", attributes: linkAttributes)
        termsText.append(linkText)
        
        self.termsTextView.attributedText = termsText
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       //self.emailTextField.becomeFirstResponder()
        
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
    
}
