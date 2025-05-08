//
//  EmailSceneDisplayLogic.swift
//  Locket
//
//  Created by sulik on 06.05.2025.
//


import UIKit


protocol NameSceneDisplayLogic: AnyObject {
    func requestRoute(_ route: NameSceneModel.Route)
    func perfromAction(_ action: NameSceneModel.Action)
    func displayContent(_ viewModel: NameSceneModel.ViewModel)
}

final class NameSceneController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    #warning("нейминг не camel case")
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var buttonBottomConstraints: NSLayoutConstraint!
    
    public var auth: Authorization = .init()
    var router: NameSceneRoutingLogic?
    var interactor: NameSceneBusinessLogic?
    
    
    // TODO: Создать экземпляры классов для итерактора и роутера
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        continueButton.layer.cornerRadius = 10
//        continueButton.clipsToBounds = true
//        continueButton.isEnabled = false
//        continueButton.backgroundColor = .systemGray
//        continueButton.setTitleColor(.white, for: .normal)
        
        interactor?.makeState(request: .start)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
    }
    
    private func setupViews() {
        NameTextField.delegate = self
        NameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        NameTextField.attributedPlaceholder = NSAttributedString(
            string: "Имя",
            attributes: [.foregroundColor: UIColor.systemGray2]
        )
        
        continueButton.layer.cornerRadius = 10
        continueButton.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func displayContent(_ viewModel: NameSceneModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .validationResult(let viewModel):
                Task { @MainActor in
                    self.continueButton.setTitleColor(viewModel.buttonTextColor, for: .normal)
                    self.continueButton.backgroundColor = viewModel.buttonBackgroundColor
                    self.continueButton.isEnabled = viewModel.buttonIsEnabled
                }
            case .display:
                Task { @MainActor in
                    
                }
            }
        }
    }
    
    private func updateButton(isEnabled: Bool,
                              backgroundColor: UIColor = .secondaryLabel,
                              textColor: UIColor = .systemGray2) {
        continueButton.isEnabled = isEnabled
        continueButton.backgroundColor = backgroundColor
        continueButton.setTitleColor(textColor, for: .normal)
        continueButton.setImage(UIImage(named: isEnabled ? "continueBlack" : "continue"), for: .normal)
    }
    
    
    func requestRoute(_ route: NameSceneModel.Route) {
        router?.routeTo(route: route)
    }
    
    func perfromAction(_ action: NameSceneModel.Action) {
        switch action {
        case .showKeyboard(let height, let duration):
            moveButton(isUpwards: true, keyboardHeight: height, duration: duration)
        case .hideKeyboard:
            moveButton(isUpwards: false, keyboardHeight: 0, duration: 0.25)
            
        case .start:
            print("")
        }
    }
    
    // MARK: - Actions
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange() {
        print("Text changed to: \(NameTextField.text ?? "")")
        interactor?.makeState(request: .nameTextDidChange(NameTextField.text ?? ""))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.interactor?.makeState(request: .nameTextDidChange(textField.text ?? ""))
        }
        return true
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let text = NameTextField.text?.trimmingCharacters(in: .whitespaces),
                  !text.isEmpty else {
                return
            }
        interactor?.makeState(request: .nameTextDidChange(text))
    }
    
    private func moveButton(isUpwards: Bool, keyboardHeight: CGFloat, duration: Double) {
        let bottomPadding = view.safeAreaInsets.bottom
        buttonBottomConstraints.constant = isUpwards ? (keyboardHeight - bottomPadding + 22) : 0
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            perfromAction(.showKeyboard(height: keyboardSize.height, duration: duration))
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        perfromAction(.hideKeyboard)
    }
    
    @objc private func dismissKeyboard() {
        NameTextField.resignFirstResponder()
    }
}
extension NameSceneController {

}
