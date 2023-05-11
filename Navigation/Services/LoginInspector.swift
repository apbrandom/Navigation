//
//  LoginInspector.swift
//  Navigation
//
//  Created by Вадим Виноградов on 25.04.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    private let checker = Checker.shared

    func check(login: String, password: String) -> Bool {
        return checker.check(userLogin: login, userPassword: password)
    }
}

class Checker {
    static let shared = Checker()

    private let login = "user"
    private let password = "password"

    private init() {}

    func check(userLogin: String, userPassword: String) -> Bool {
        return userLogin == login && userPassword == password
    }
}


