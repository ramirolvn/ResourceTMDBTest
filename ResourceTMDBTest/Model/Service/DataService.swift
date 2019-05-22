//
//  DataService.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima on 11/8/18.
//  Copyright © 2018 Ramiro Lima. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class DataService {
    static let shared = DataService()
    private let mainURL = "https://api.themoviedb.org/3"
    private let contactsUrl = "https://api.androidhive.info/contacts/"
    
    func fetchContacts(completion: @escaping ([[String : AnyObject]]?, String?) -> ()) {
        Alamofire.request(contactsUrl)
            .responseJSON { (response) -> Void in
                if let error = response.error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                if let responseJson = response.result.value {
                    let jsonObj = JSON(responseJson)
                    if let contactsObj = jsonObj["contacts"].arrayObject {
                        let contacts = contactsObj as? [[String: AnyObject]]
                        completion(contacts, nil)
                        return
                    }
                }
        }
    }
}
