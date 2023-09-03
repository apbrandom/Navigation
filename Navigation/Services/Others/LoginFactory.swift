//
//  LoginFactory.swift
//  Navigation
//
//  Created by Вадим Виноградов on 27.04.2023.
//

struct LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        let checkerService = CheckerService.shared
        return LoginInspector(checkerService: checkerService)
    }
}

