//
//  RegistrationViewController.swift
//  Locket
//
//  Created by Сулейман on 23.10.2024.
//

import Foundation
import UIKit


struct RegistrationEmailViewModel {
    
    let mainTitle: String = "Прив"
    let emailPlaceholder: String
    let emailText: String?
    let termsText: NSAttributedString
    let button: ButtonViewModel
    
    let onTextChange: (String) -> ()
    
    struct ButtonViewModel {
        
        let text: String
        let color: UIColor
        let onSelect: () -> ()
        
    }
    
    
    
}


class RegistrationEmailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var termsTextView: UITextView!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var continueButton: UIButton!
    
    private var auth: Authorization = .init()
    
    private let service: RegistrantionService = .init()
    
    var viewModel: RegistrationEmailViewModel? {
        didSet {
            render()
        }
    }
    
    private func render() {
        guard let viewModel else { return }
        self.continueButton.tintColor = viewModel.button.color
        self.continueButton.setTitle(viewModel.button.text, for: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
        
        self.navigationItem.hidesBackButton = true
        
        let placeholder = "Example@mail.ru"
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        emailTextField.text = ""
        emailTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        continueButton.layer.cornerRadius = 10
        continueButton.clipsToBounds = true
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor.secondaryLabel
        let attributedTitle = NSAttributedString(string: "Продолжить", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        continueButton.setAttributedTitle(attributedTitle, for: .normal)
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
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
        
        let termsText = NSMutableAttributedString(string: "Нажимая продолжить, вы соглашаетесь с ", attributes: attributes)
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .link: URL(string: "https://apple.com")!
        ]
        
        let linkText = NSAttributedString(string: "условиями сервиса", attributes: linkAttributes)
        termsText.append(linkText)
        
        self.termsTextView.attributedText = termsText
        self.termsTextView.isEditable = false // Убедитесь, что текстовое поле не редактируемое
        self.termsTextView.isSelectable = true // Позволяем выбор текста
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func emailTextFieldEditingChanged(_ sender: UITextField) {
        
        continueButton.layer.cornerRadius = 10
        continueButton.clipsToBounds = true
        let email = sender.text
        
        if service.validateEmail(email!) {
            
            continueButton.backgroundColor = UIColor.systemOrange
            let attributedTitle = NSAttributedString(string: "Продолжить", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            continueButton.setAttributedTitle(attributedTitle, for: .normal)
            continueButton.isEnabled = true
            continueButton.setImage(UIImage(named: "continueBlack"), for: .normal)
            
        } else {
            
            continueButton.backgroundColor = UIColor.secondaryLabel
            let attributedTitle = NSAttributedString(string: "Продолжить", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
            continueButton.setAttributedTitle(attributedTitle, for: .normal)
            continueButton.isEnabled = false
            continueButton.setImage(UIImage(named: "continue"), for: .normal)
            
        }
    }
    
    
    @objc func dismissKeyboard() {
        
        emailTextField.resignFirstResponder()
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func continueButton(_ sender: Any) {
        
        self.auth.email = emailTextField.text ?? ""
        
        let storyboard = UIStoryboard(name: "RegistrationNameViewController", bundle: nil)
        if let regNameViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationNameViewController") as? RegistrationNameViewController {
            navigationController?.pushViewController(regNameViewController, animated: true)
        } else {
            print("Не удалось найти RegistrationNameViewController в Storyboard")
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
    
}
