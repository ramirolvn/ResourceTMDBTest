//
//  ContactsViewModel.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima on 11/8/18.
//  Copyright © 2018 Ramiro Lima. All rights reserved.
//

import Foundation
class LoginViewModel {
    private(set) public var error: String?
    private(set) public var contacts: [[String: AnyObject]]? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    private var dataService: DataService
    var didFinishFetch: (() -> ())?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func loginUser(email: String, password: String ) {
        dataService.fetchContacts(completion: { (contacts, error) in
            if let error = error {
                self.error = error
                return
            }
            self.contacts = contacts!
        })
    }
}
