//
//  EmailSceneDisplayLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit


protocol RegistrationSceneDisplayLogic: AnyObject {
    func requestRoute(_ route: RegistrationSceneModel.Route)
    func perfromAction(_ action: RegistrationSceneModel.Action)
    func displayContent(_ viewModel: RegistrationSceneModel.ViewModel)
    func moveButtonForKeyboard(isUpwards: Bool, keyboardHeight: CGFloat, duration: Double)
}

final class RegistrationSceneController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var labelScrollView: UIScrollView!
    @IBOutlet weak var registrationTextView: UITextView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var registrationTextField: UITextField!
    @IBOutlet weak var textViewScrollView: UIScrollView!
    @IBOutlet weak var emailTextView: UITextView!
    @IBOutlet weak var nicknameTextView: UITextView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var passwordTextView: UITextView!
    
    var router: RegistrationSceneRoutingLogic?
    var interactor: RegistrationSceneBusinessLogic?
    private var currentField: RegistrationSceneModel.FieldType = .email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = RegistationScenePresenter(controller: self)
        self.interactor = RegistrationSceneInteractor(presenter: presenter)
        self.router = RegistrationSceneRouter(controller: self, dataStore: interactor as! RegistrationSceneDataStore)
        
        registrationTextField.delegate = self
        continueButton.clipsToBounds = true
        continueButton.layer.cornerRadius = 8
        
        updateTextField(for: .email)
        
        setupViews()
        setupScrollView()
        setupkeyboard()
        setupTapGesture()
        emailText()
        
        self.interactor?.makeState(request: .start)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
    }
    
    private func setupViews(){
        registrationTextField.delegate = self
        registrationTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector( continueButtonTapped), for: .touchUpInside)
        updateContinueButton()
    }
    
    // MARK: Action backButton and continueButton
    @IBAction func backButton(_ sender: Any) {
        
        if currentField == .email {
            navigationController?.popViewController(animated: true)
        } else {
            guard let previousField = currentField.previous else { return }
            scrollToField(type: previousField)
            
            // Обновляем состояние кнопки
            continueButton.isEnabled = false
            updateContinueButton()
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        switch currentField {
        case .email:
            if let text = registrationTextField.text, RegistrantionService().validateEmail(text) {
                interactor?.makeState(request: .proceedToNextField)
                continueButton.isEnabled = false
                updateContinueButton()
            }
        case .nickname:
            if let text = registrationTextField.text, RegistrantionService().validateNickname(text) {
                interactor?.makeState(request: .proceedToNextField)
                continueButton.isEnabled = false
                updateContinueButton()
            }
        case .name:
            if let text = registrationTextField.text, RegistrantionService().validateName(text) {
                interactor?.makeState(request: .proceedToNextField)
                continueButton.isEnabled = false
                updateContinueButton()
            }
        case .password:
            if let text = registrationTextField.text, RegistrantionService().validatePassword(text) {
                let storyboard = UIStoryboard(name: "RegLoadingViewController", bundle: nil)
                if let regNameViewController = storyboard.instantiateViewController(withIdentifier: "RegLoadingViewController") as? RegLoadingViewController {
                    navigationController?.pushViewController(regNameViewController, animated: true)
                } else {
                    
                    print("Не удалось найти RegLoadingViewController в Storyboard")
                    
                }
            }
        }
    }
    private func updateContinueButton() {
        continueButton.backgroundColor = continueButton.isEnabled ? .systemOrange : .secondaryLabel
        continueButton.setTitleColor(continueButton.isEnabled ? .black : .systemGray, for: .normal)
    }
    
    // MARK: Работа с клавиатурой
    
    private func setupkeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            interactor?.makeState(request: .keyboardWillShow(height: keyboardSize.height, duration: duration))
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        interactor?.makeState(request: .keyboardWillHide)
    }
    
    @objc func dismissKeyboard() {
        interactor?.makeState(request: .dismissKeyboard)
        view.endEditing(true)
    }
    
    // MARK: Работа с текстом для emailTextView
    
    private func emailText() {
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
        
        self.emailTextView.attributedText = termsText
        self.emailTextView.isEditable = false // Убедитесь, что текстовое поле не редактируемое
        self.emailTextView.isSelectable = true // Позволяем выбор текста
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    // MARK: Работа со Scroll
    
    private func setupScrollView() {
        
        let labelWidth = labelScrollView.bounds.width
        let labelHeight = labelScrollView.bounds.height
        
        emailLabel.frame = CGRect(x: 0, y: 0, width: labelWidth, height: labelHeight)
        nicknameLabel.frame = CGRect(x: labelWidth, y: 0, width: labelWidth, height: labelHeight)
        nameLabel.frame = CGRect(x: labelWidth * 2, y: 0, width: labelWidth, height: labelHeight)
        passwordLabel.frame = CGRect(x: labelWidth * 3, y: 0, width: labelWidth, height: labelHeight)
        
        let textViewWidth = textViewScrollView.bounds.width
        let textViewHeight = textViewScrollView.bounds.height
        
        emailTextView.frame = CGRect(x: 0, y: 0, width: textViewWidth, height: textViewHeight)
        nicknameTextView.frame = CGRect(x: textViewWidth, y: 0, width: textViewWidth, height: textViewHeight)
        nameTextView.frame = CGRect(x: textViewWidth * 2, y: 0, width: textViewWidth, height: textViewHeight)
        passwordTextView.frame = CGRect(x: textViewWidth * 3, y: 0, width: textViewWidth, height: textViewHeight)
        
    }
    
    
    private func scrollToField(type: RegistrationSceneModel.FieldType) {
        let allFields = RegistrationSceneModel.FieldType.allCases
        let targetIndex = allFields.firstIndex(of: type)!
        
        currentField = type
        updateTextField(for: type)
        
        let pageWidthLabel = labelScrollView.bounds.width
        let newOffsetLabel = CGFloat(targetIndex) * pageWidthLabel
        
        
        UIView.animate(withDuration: 0.3) {
            self.labelScrollView.contentOffset = CGPoint(x: newOffsetLabel, y: 0)
        }
        
        let pageWidthTextView = labelScrollView.bounds.width
        let newOffsetTextView = CGFloat(targetIndex) * pageWidthTextView
        
        UIView.animate(withDuration: 0.3){
            self.textViewScrollView.contentOffset = CGPoint(x: newOffsetTextView, y: 0)
        }
        self.view.layoutIfNeeded()
    }
    // MARK: Работа с textField
    private func updateField(type: RegistrationSceneModel.FieldType, isValid: Bool) {
        let labels: [RegistrationSceneModel.FieldType: UILabel] = [
            .email:emailLabel,
            .nickname: nicknameLabel,
            .name: nameLabel,
            .password: passwordLabel]
    }
    
    @objc private func textFieldDidChange() {
        interactor?.makeState(request: .validateField(text: registrationTextField.text ?? "", type: currentField))
    }
    
    
    private func updateTextField(for type: RegistrationSceneModel.FieldType) {
        registrationTextField.text = ""
        registrationTextField.isSecureTextEntry = type == .password
        switch type {
            case .email:
                registrationTextField.placeholder = "Example@mail.com"
            case .nickname:
                registrationTextField.placeholder = "IvanNumberOne"
            case .name:
                registrationTextField.placeholder = "Иван"
            case .password:
                registrationTextField.placeholder = "***"
            }
        registrationTextField.attributedPlaceholder = NSAttributedString(
                string: registrationTextField.placeholder ?? "",
                attributes: [
                    .foregroundColor: UIColor.systemGray2,
                ]
            )
    }
}

extension RegistrationSceneController: RegistrationSceneDisplayLogic{
    
    func moveButtonForKeyboard(isUpwards: Bool, keyboardHeight: CGFloat, duration: Double) {
        let bottomPadding = view.safeAreaInsets.bottom
        buttonBottomConstraint.constant = isUpwards ? (keyboardHeight - bottomPadding + 22) : 0
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func requestRoute(_ route: RegistrationSceneModel.Route) {
        switch route {
        case .route:
            Task { @MainActor in
                
            }
        }
    }
    
    func perfromAction(_ action: RegistrationSceneModel.Action) {
        switch action {
        case .action:
            break
        }
    }
    
    func displayContent(_ viewModel: RegistrationSceneModel.ViewModel) {
        switch viewModel {
        case .display:
            Task { @MainActor in
                
            }
        case .keyboardAdjustment(height: let height, duration: let duration):
            moveButtonForKeyboard(isUpwards: true, keyboardHeight: height, duration: duration)
            
        case .keyboardReset:
            moveButtonForKeyboard(isUpwards: false, keyboardHeight: 0, duration: 0)
            
        case .updateButtonState(isEnabled: let isEnabled):
            self.continueButton.isEnabled = isEnabled
            self.updateContinueButton()
            
        case .updateField(type: let type, isValid: let isValid):
            self.updateField(type: type, isValid: isValid)
            self.currentField = type
            
        case .scrollToField(type: let type):
            self.scrollToField(type: type)
            self.updateTextField(for: type)
        }
    }
}
