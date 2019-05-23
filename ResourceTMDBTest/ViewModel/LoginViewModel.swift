import Foundation
class LoginViewModel {
    private(set) public var error: String?
    private(set) public var user: User? {
        didSet {
            self.didFinishReq?()
        }
    }
    
    private var dataService: DataService
    var didFinishReq: (() -> ())?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func loginUser(username: String?, password: String?) {
        if let u = username, let p = password, u.count > 0 , p.count > 0{
            dataService.userLogin(username: u, password: p, completion: {
                (user, error) in
                if let user = user{
                    let saveUser = UserDao.saveUser(user)
                    if saveUser.0{
                        self.error = nil
                        self.user = user
                    }else{
                        self.error = saveUser.1!
                        self.user = nil
                    }
                }else{
                    self.error = error!
                    self.user = nil
                    return
                }
            })
        }else{
            self.error = "Usuário ou senha inválidos!"
            return
        }
    }
}
