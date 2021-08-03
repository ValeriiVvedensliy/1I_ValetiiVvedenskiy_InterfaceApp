import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    
    @objc func showKeyBoard(_ notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyBoardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize?.height ?? 0, right: 0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        scrollView.scrollRectToVisible(button.frame, animated: true)
    }

    @objc func hideKeyBoard(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !isLogingFieldsValid() {
            showErrorPopUp()
            return false
        }
        
        return true
    }
    
    private func isLogingFieldsValid() -> Bool {
        !(loginTextField.text?.isEmpty ?? false) && !(passwordTextField.text?.isEmpty ?? false)
    }
    
    private func showErrorPopUp () {
        let alert = UIAlertController(title: "Error", message: "Fields can not be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

