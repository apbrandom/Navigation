//
//  LoginManager.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 02.09.2023.
//

import Foundation
import FirebaseAuth

class LoginManager {
    private let checkerService: CheckerServiceProtocol
    private let keychainService: CredentialsStorable
    private let realmService: RealmService
    
    init(checkerService: CheckerServiceProtocol, keychainService: KeychainServiceProtocol, realmService: RealmService) {
        self.checkerService = checkerService
        self.keychainService = keychainService
        self.realmService = realmService
    }

    func handleSignIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        checkerService.checkCredentials(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResult):
                self?.keychainService.saveCredentials(email: email, password: password)
                self?.realmService.saveUser(email: email, password: password)
                completion(.success(authResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

