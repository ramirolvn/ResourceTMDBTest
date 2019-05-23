import Foundation
import SwiftyJSON

struct Token {
    private(set) public var expires_at: Date? = nil
    private(set) public var request_token: String = ""
    
    init?(tokenJson: JSON) {
        guard let expires_atStr = tokenJson["expires_at"].string else { return nil}
        guard let request_token = tokenJson["request_token"].string else { return nil}
        guard let expires_atDate = expires_atStr.utcDate else { return nil}
        self.expires_at =  expires_atDate
        self.request_token = request_token
    }
}
