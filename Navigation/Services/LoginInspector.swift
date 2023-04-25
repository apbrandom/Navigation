//
//  LoginInspector.swift
//  Navigation
//
//  Created by Вадим Виноградов on 25.04.2023.
//

import Foundation

class loginInspector: loginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(userLogin: login, userPassword: password)
    }
}
