import Alamofire
import SwiftyJSON
import Foundation

@testable import ResourceTMDBTest

class FakeDataProvider: DataService {
    
    func userLoginTest(username: String, password: String, completion: @escaping (User?, String?) -> ()) {
        if username == "ramiro" && password == "password"{
            
            completion(User(username: username, password: password, token: nil), nil)
        }else{
            completion(nil, "Usuário e/ou senha incorretos!")
        }
    }
    
    //    func fetchMoviesFake(page: Int, completion: @escaping ([Movie]?, String?) -> ()) {
    //        if page == 1{
    //            let fakeResult = [""]
    //            completion(fakeResult, nil)
    //        }else{
    //            completion(nil, "Erro ao pegar filmes!")
    //        }
    //    }
    
}
