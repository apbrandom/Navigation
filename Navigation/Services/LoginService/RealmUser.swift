//
//  User.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 01.09.2023.
//

import RealmSwift

class RealmUser: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    
    convenience init(email: String, password: String) {
           self.init()
           self.email = email
           self.password = password
       }
}
