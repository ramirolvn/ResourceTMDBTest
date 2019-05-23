import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var username: String = ""
    @objc dynamic var token: Token? = nil
    
    required convenience init?(username: String, password: String, token: Token) {
        self.init()
        self.username = username
        self.token = token
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
