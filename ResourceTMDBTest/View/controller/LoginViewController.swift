import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    private var viewmodel = LoginViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.loading(nil)
        viewmodel.loginUser(username: self.emailTxt.text, password: self.passwordTxt.text)
        viewmodel.didFinishReq = {
            self.dismissLoading()
            if let e = self.viewmodel.error{
                self.presentAlertWithTitle(title: "Atenção", message: e, options: "Ok", completion: {_ in})
            }else{
                let u = self.viewmodel.user!
                let saveUser = UserDao.saveUser(u)
                if saveUser.0{
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let mainNav = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                    let mainVC = mainNav.viewControllers[0] as! ViewController
                    mainVC.user = u
                    appDelegate.window?.rootViewController = mainNav
                }else{
                    self.presentAlertWithTitle(title: "Atenção", message: saveUser.1!, options: "Ok", completion: {_ in})
                }
                
            }
        }
    }
}
