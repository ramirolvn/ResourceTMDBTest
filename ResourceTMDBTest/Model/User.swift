import Foundation
import SwiftyJSON

struct User {
    private(set) public var username: String = ""
    private(set) public var token: Token? = nil
    
    init(username: String, password: String, token: Token) {
        self.username = username
        self.token = token
    }
}
