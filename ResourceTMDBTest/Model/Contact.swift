//
//  Contact.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima on 11/8/18.
//  Copyright © 2018 Ramiro Lima. All rights reserved.
//

import Foundation
struct Contact {
    private(set) public var name: String!
    private(set) public var email: String!
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
