//
//  LoginInspector.swift
//  Navigation
//
//  Created by Вадим Виноградов on 25.04.2023.
//

import Foundation
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {

    private let checkerService: CheckerServiceProtocol
    
    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }

    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        checkerService.checkCredentials(email: email, password: password) { result in
            completion(result)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        checkerService.signUp(email: email, password: password) { result in
            completion(result)
        }
    }
}




