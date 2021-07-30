import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }

    private func setUpView() {
        rootView.backgroundColor = UIColor.darkGray
        imageView.layer.cornerRadius = 15
        stackView.layer.cornerRadius = 15
        loginTextField.textColor = UIColor.white
        setPlaceholder(textField: loginTextField, text: "Email или телефон")
        passwordTextField.textColor = UIColor.white
        setPlaceholder(textField: passwordTextField, text: "Пароль")
        button.layer.cornerRadius = 15
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
    }
    
    private func setPlaceholder(textField: UITextField, text: String){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 22
        let attributes = [
          NSAttributedString.Key.paragraphStyle: paragraphStyle,
          NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
      textField.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }

}

