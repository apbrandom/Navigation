//
//  LoginInspector.swift
//  Navigation
//
//  Created by Вадим Виноградов on 25.04.2023.
//

struct LoginInspector: LoginViewControllerDelegate {
    private let checker: Checker

    init(checker: Checker) {
        self.checker = checker
    }

    func check(login: String, password: String) -> Bool {
        return checker.check(userLogin: login, userPassword: password)
    }
}

class Checker {
    private let login = "user"
    private let password = "password"

    func check(userLogin: String, userPassword: String) -> Bool {
        return userLogin == login && userPassword == password
    }
}


