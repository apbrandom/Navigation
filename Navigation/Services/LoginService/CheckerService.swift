//
//  ChekerService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 22.06.2023.
//

import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()

    private init() {}
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
}
