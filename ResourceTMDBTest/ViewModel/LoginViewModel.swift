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
                    self.error = nil
                    self.user = user
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
