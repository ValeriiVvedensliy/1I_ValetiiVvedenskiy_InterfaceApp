import UIKit

class LoginPageViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dotsView: UIView!
    @IBOutlet weak var loginView: LoginPageView!
    @IBOutlet weak var errorView: UIView!
    
    private var lay = CAReplicatorLayer()
    private var isValided = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fieldsIsValide(notification:)),
                                               name: Notification.Name.validationFields, object: nil)
    }
    
    private func setUpView() {
        rootView.backgroundColor = UIColor.darkGray
        imageView.layer.cornerRadius = 12
        errorView.layer.cornerRadius = 12
        errorView.isHidden = true
        scrollView.isScrollEnabled = false
        dotsView.backgroundColor = .black.withAlphaComponent(0.4)
        dotsView.isHidden = true
    }
    
    @objc func fieldsIsValide(notification: NSNotification) {
        guard let login = notification.userInfo?["login"] as? String,
              let password = notification.userInfo?["password"] as? String else { return }
        
        isValided = isLogingFieldsValid(login: login, password: password)
        performSegue(withIdentifier: "toNextVc", sender: nil)
    }
    
    @objc func showKeyBoard(_ notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyBoardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize?.height ?? 0, right: 0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        scrollView.scrollRectToVisible(loginView.frame, animated: true)
    }

    @objc func hideKeyBoard(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.isScrollEnabled = true
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
        lay.frame = CGRect(x: (view.frame.width / 2) - 30 , y: (view.frame.height / 2) - 20, width: 60, height: 20)
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.white.cgColor
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
        if !isValided {
            errorView.isHidden = false
            return
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TableViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func isLogingFieldsValid(login: String, password: String) -> Bool {
        return login.count >= 4 && password.count >= 6
    }
}

