//
//  MockDataService.swift
//  ResourceTMDBTestTests
//
//  Created by Ramiro Lima on 11/19/18.
//  Copyright © 2018 Ramiro Lima. All rights reserved.
//

import Foundation
@testable import ResourceTMDBTest

class MockDataService: DataServiceProtocol {
    var completeClosure: (([[String : AnyObject]]?, String?) -> ())!
    var contacts: [[String : AnyObject]] = [[String : AnyObject]]()
    var isFetchContactsCalled = false
    
    func fetchContacts(completion: @escaping ([[String : AnyObject]]?, String?) -> ()) {
        isFetchContactsCalled = true
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure(contacts, nil)
    }
    
    func fetchFail(error: String?) {
        completeClosure(nil, error)
    }
}
