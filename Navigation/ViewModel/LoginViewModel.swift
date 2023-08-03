//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 03.08.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var onShowError: ((Error) -> Void)?
    var onSignInSuccessful: ((AuthDataResult) -> Void)?
    var onSignUpSuccessful: ((AuthDataResult) -> Void)?

    private var loginInspector: LoginInspector

    init(loginInspector: LoginInspector) {
        self.loginInspector = loginInspector
    }
    
    func signIn(email: String, password: String) {
        loginInspector.checkCredentials(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResult):
                self?.onSignInSuccessful?(authResult)
            case .failure(let error):
                self?.onShowError?(error)
            }
        }
    }
    
}
