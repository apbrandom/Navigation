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
    
    convenience init(email: String) {
           self.init()
           self.email = email
       }
}
