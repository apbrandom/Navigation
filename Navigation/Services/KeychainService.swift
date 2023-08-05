//
//  KeychainService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 05.08.2023.
//

import KeychainAccess

protocol KeychainServiceProtocol {
    func save(email: String, password: String) 
    func retrieveEmail() -> String?
    func retrievePassword() -> String?
    func clearCredentials() -> Bool
}

final class KeychainService: KeychainServiceProtocol {
    static let shared = KeychainService()
    
    private let keychain = Keychain(service: "ru.apbrandom.Navigation")

    private init() {}

    func save(email: String, password: String) {
        keychain["userEmail"] = email
        keychain["userPassword"] = password
    }

    func retrieveEmail() -> String? {
        return keychain["userEmail"]
    }

    func retrievePassword() -> String? {
        return keychain["userPassword"]
    }

    func clearCredentials() -> Bool {
        do {
            try keychain.remove("userEmail")
            try keychain.remove("userPassword")
            return true
        } catch {
            print("Error when deleting credentials: \(error)")
            return false
        }
    }
}
