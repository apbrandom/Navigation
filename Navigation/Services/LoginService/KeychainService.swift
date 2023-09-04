//
//  KeychainService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 05.08.2023.
//

import Foundation
import KeychainAccess

protocol CredentialsStorable {
    func saveCredentials(email: String, password: String)
    func getCredentials() -> (email: String, password: String)?
    func clearCredentials()
}

protocol KeychainServiceProtocol: CredentialsStorable {
    func saveEncryptionKey(key: Data)
    func retrieveEncryptionKey() -> Data?
}

class KeychainService: KeychainServiceProtocol {
    
    static let shared = KeychainService()
    
    private let keychain = Keychain(service: "ru.apbrandom.Navigation")
    
    private init() {}

    func saveCredentials(email: String, password: String) {
        keychain["userEmail"] = email
        keychain["userPassword"] = password
    }

    func getCredentials() -> (email: String, password: String)? {
        if let email = keychain["userEmail"],
           let password = keychain["userPassword"] {
            return (email, password)
        }
        return nil
    }
    
    func clearCredentials() {
        do {
            try keychain.remove("userEmail")
            try keychain.remove("userPassword")
        } catch {
            print("Error when deleting credentials: \(error)")
        }
    }
    
    func saveEncryptionKey(key: Data) {
        keychain[data: "encryptionKey"] = key
    }

    func retrieveEncryptionKey() -> Data? {
        return keychain[data: "encryptionKey"]
    }
}
