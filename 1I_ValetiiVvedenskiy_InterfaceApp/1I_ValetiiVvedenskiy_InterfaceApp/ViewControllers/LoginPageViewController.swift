import UIKit

class LoginPageViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dotsView: UIView!
    
    private var lay = CAReplicatorLayer()
    private var isValid = false
    
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
        dotsView.layer.cornerRadius = 12
        dotsView.backgroundColor = .black
        dotsView.isHidden = true
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
    
    @IBAction func tapButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toNextVc", sender: nil)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        startAnimation()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: { [self] in
            lay.removeFromSuperlayer()
            dotsView.isHidden = true
        })
    }
    
    private func startAnimation() {
        dotsView.isHidden = false
        lay = CAReplicatorLayer()
        lay.frame = CGRect(x: 15 , y: (dotsView.bounds.width / 2) - 20 , width: 60, height: 20)
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(30, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        anim.delegate = self
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        dotsView.layer.addSublayer(lay)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !isLogingFieldsValid() {
            showErrorPopUp()
            return
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TableViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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

