//
//  LoginFactory.swift
//  Navigation
//
//  Created by Вадим Виноградов on 27.04.2023.
//

struct MyLoginFactory {
    func makeLoginInspector() -> LoginInspector {
        let checker = Checker()
        return LoginInspector(checker: checker)
    }
}
