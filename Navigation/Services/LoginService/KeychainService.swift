//
//  KeychainService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 05.08.2023.
//

import Foundation
import KeychainAccess

protocol CredentialsStorable {
    func saveCredentials(password: String)
    func getCredentials() -> (String)?
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

    func saveCredentials(password: String) {
        keychain["userPassword"] = password
    }

    func getCredentials() -> (String)? {
           if let password = keychain["userPassword"] {
            return password
        }
        return nil
    }
    
    func clearCredentials() {
        do {
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
