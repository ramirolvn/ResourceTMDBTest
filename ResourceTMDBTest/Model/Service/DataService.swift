import Alamofire
import SwiftyJSON
import Foundation

class DataService {
    static let shared = DataService()
    private let apiKey = "2b70971671061eb97ab39ed81b6ec2ea"
    private let mainURL = "https://api.themoviedb.org/3/"
    private let contactsUrl = "https://api.androidhive.info/contacts/"
    
    
    
    fileprivate func newToken(completion: @escaping (Token?, String?) -> ()) {
        Alamofire.request(mainURL+"authentication/token/new?api_key=\(apiKey)")
            .responseJSON { (response) -> Void in
                if let error = response.error {
                    completion(nil, error.localizedDescription)
                }
                
                if let responseJson = response.result.value {
                    let jsonObj = JSON(responseJson)
                    
                    if let sucess = jsonObj["success"].bool, sucess, let token = Token(tokenJson: jsonObj) {
                        completion(token, nil)
                    }else{
                        completion(nil, "Erro ao gerar token!")
                    }
                }
        }
    }
    
    func userLogin(username: String, password: String, completion: @escaping (User?, String?) -> ()) {
        newToken(completion: {
            (token, error) in
            if let t = token{
                let body = ["username" : username, "password" : password, "request_token" : t.request_token]
                Alamofire.request(self.mainURL+"/authentication/token/validate_with_login?api_key=\(self.apiKey)", method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) -> Void in
                    if let error = response.error {
                        completion(nil, error.localizedDescription)
                    }
                    
                    if let responseJson = response.result.value {
                        let jsonObj = JSON(responseJson)
                        if let sucess = jsonObj["success"].bool, sucess {
                            let user = User(username: username, password: password, token: t)
                            completion(user, nil)
                        }else if let status_code = jsonObj["status_code"].int, status_code == 30{
                            completion(nil, "Usuário ou senha inválidos!")
                        }else{
                            completion(nil, "Erro no login!")
                        }
                    }
                }
            }else{
                completion(nil, error ?? "Erro no Login!")
            }
        })
    }
    
    
    
    func fetchMovies(page: Int, completion: @escaping (ResultMovies?, String?) -> ()) {
        Alamofire.request(mainURL+"movie/upcoming?api_key=\(apiKey)&page=\(page)")
            .responseJSON { (response) -> Void in
                if let error = response.error {
                    completion(nil, error.localizedDescription)
                }
                if let responseJson = response.result.value {
                    let jsonObj = JSON(responseJson)
                    if let resultMovies =  ResultMovies(result: jsonObj){
                        completion(resultMovies, nil)
                    }else{
                        completion(nil, "Erro ao carregar filmes!")
                    }
                }else{
                    completion(nil, "Erro ao carregar filmes!")
                }
        }
    }
    
    func fetchSpecificMovie(movieID: Int, completion: @escaping (Movie?, String?) -> ()) {
        Alamofire.request(mainURL+"movie/\(movieID)?api_key=\(apiKey)")
            .responseJSON { (response) -> Void in
                if let error = response.error {
                    completion(nil, error.localizedDescription)
                }
                if let responseJson = response.result.value {
                    let jsonObj = JSON(responseJson)
                    if let movie =  Movie(movie: jsonObj){
                        completion(movie, nil)
                    }else{
                        completion(nil, "Erro ao carregar filme!")
                    }
                }else{
                    completion(nil, "Erro ao carregar filme!")
                }
        }
    }
}
