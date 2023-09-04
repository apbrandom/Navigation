//
//  RealmService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 01.09.2023.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    private var realm: Realm?
    
    private init() {
        // Get encryption key from Keychain or create a new one
        var key: Data
        if let retrievedKey = KeychainService.shared.retrieveEncryptionKey() {
            key = retrievedKey
        } else {
            // Generate a 64-byte encryption key
            key = Data(count: 64)
            key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
                guard let bytes = pointer.baseAddress else { return }
                _ = SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
            }
            
            // Save the key to Keychain
            KeychainService.shared.saveEncryptionKey(key: key)
        }
        
        // Initialize Realm with encryption key
        let config = Realm.Configuration(encryptionKey: key)
        
        do {
            realm = try Realm(configuration: config)
        } catch let error as NSError {
            print("Error initializing Realm: \(error)")
        }
    }
    
    func saveUser(email: String) {
            guard let realm = realm else {
                print("Realm is not initialized.")
                return
            }

            let user = RealmUser(email: email) 
            do {
                try realm.write {
                    realm.add(user)
                }
            } catch {
                print("RealmService saveUser: \(error.localizedDescription)")
            }
        }

    func retrieveUser(email: String) -> RealmUser? {
        guard let realm = realm else {
            print("Realm is not initialized.")
            return nil
        }
        
        return realm.objects(RealmUser.self).filter("email = %@", email).first
    }
}

