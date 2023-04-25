//
//  Checker.swift
//  Navigation
//
//  Created by Вадим Виноградов on 25.04.2023.
//

import Foundation

class Checker {
    static let shared = Checker()
    
    private let login: String
    private let password: String
    
    private init() {
        self.login = "user1"
        self.password = "password"
    }
    
    func check(userLogin: String, userPassword: String) -> Bool {
        return userLogin == login && userPassword == password
    }
    
}
