//
//  LoginPageView.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 30.08.2021.
//

import UIKit

class LoginPageView: UIView {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var confirmButton: UIButton!
    private var login = ""
    private var password = ""
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            AutoresizingMask.flexibleWidth,
            AutoresizingMask.flexibleHeight
        ]
        setupView()
        addSubview(view)
    }
    
    @IBAction func loginFieldChanged(_ sender: UITextField) {
        login = sender.text ?? ""
        buttonIsEnabled()
    }
    
    @IBAction func passwordFieldChanged(_ sender: UITextField) {
        password = sender.text ?? ""
        buttonIsEnabled()
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.validationFields,
                                        object: nil,
                                        userInfo: ["login": login, "password": password])
    }
    
    func setupView() {
        stackView.layer.cornerRadius = 12
        stackView.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        stackView.layer.borderWidth = 1
        confirmButton.layer.cornerRadius = 12
        confirmButton.alpha = 0.5
        confirmButton.isEnabled = false
        setPlaceholder(textField: loginField, text: "Email или телефон")
        setPlaceholder(textField: passwordField, text: "Пароль")
        loginField.textColor = .white
        passwordField.textColor = .white
    }
    
    private func setPlaceholder(textField: UITextField, text: String){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 22
        let attributes = [
          NSAttributedString.Key.paragraphStyle: paragraphStyle,
          NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
        ]
        
      textField.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    private func buttonIsEnabled() {
        confirmButton.isEnabled = !login.isEmpty && !password.isEmpty
        confirmButton.alpha = confirmButton.isEnabled ? 1 : 0.5
    }
}
