import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    private var viewmodel = LoginViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTxt.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginAction(textField)
        return true
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.loading()
        viewmodel.loginUser(username: self.emailTxt.text, password: self.passwordTxt.text)
        viewmodel.didFinishReq = {
            self.dismissLoading()
            if let e = self.viewmodel.error{
                self.presentAlertWithTitle(title: "Atenção", message: e, options: "Ok", completion: {_ in})
            }else{
                let u = self.viewmodel.user!
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let mainNav = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                let mainVC = mainNav.viewControllers[0] as! ViewController
                mainVC.user = u
                appDelegate.window?.rootViewController = mainNav
            }
        }
    }
}
