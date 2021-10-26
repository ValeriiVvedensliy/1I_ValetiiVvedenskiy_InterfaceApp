import UIKit
import WebKit
import FirebaseDatabase

class LoginPageViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var webView: WKWebView!

    var session = Session.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        rootView.backgroundColor = UIColor.darkGray
        webView.backgroundColor = UIColor.darkGray
        webView.navigationDelegate = self
        loadingPage()
    }
    
    private func loadingPage() {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: "7973114"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.81")
        ]

        guard let url = urlConstructor.url  else { return }
        let request = URLRequest(url: url)

        webView.load(request)
    }
    
    func removeCookie() {
        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore

        cookieStore.getAllCookies {
            cookies in
            for cookie in cookies {
                cookieStore.delete(cookie)
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
                 decisionHandler(.allow)
                 return
              }
        
           let params = fragment
               .components(separatedBy: "&")
               .map { $0.components(separatedBy: "=") }
               .reduce([String: String]()) { result, param in
                   var dict = result
                   let key = param[0]
                   let value = param[1]
                   dict[key] = value
                   return dict
           }

           if let token = params["access_token"], let userID = params["user_id"] {
               session.token = token
               session.userID = Int(userID)!

               decisionHandler(.cancel)
               writeUserToFirebase(userID)

               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let vc = storyBoard.instantiateViewController(withIdentifier: "TableViewController")
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true, completion: nil)
           } else {
               decisionHandler(.allow)
               
               webView.load(URLRequest(url: URL(string: "https://vk.com/")!))
           }
       }
    
    private func writeUserToFirebase(_ userID: String){
        let database = Database.database()
        let ref: DatabaseReference = database.reference(withPath: "All logged users")
        
        ref.observe(.value) { snapshot in
            let users = snapshot.children.compactMap { $0 as? DataSnapshot }
            let keys = users.compactMap { $0.key }
            
            guard keys.contains(userID) == false else {
                ref.removeAllObservers()
                return
            }
            
            ref.child(userID).setValue(userID)
        }
    }
}

