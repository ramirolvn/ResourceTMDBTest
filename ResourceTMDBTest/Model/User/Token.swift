import Foundation
import SwiftyJSON
import RealmSwift

class Token : Object {
    @objc dynamic var expires_at: Date? = nil
    @objc dynamic var request_token: String = ""
    
    required convenience init?(tokenJson: JSON) {
        self.init()
        guard let expires_atStr = tokenJson["expires_at"].string else { return nil}
        guard let request_token = tokenJson["request_token"].string else { return nil}
        guard let expires_atDate = expires_atStr.utcDate else { return nil}
        self.expires_at =  expires_atDate
        self.request_token = request_token
    }
}
