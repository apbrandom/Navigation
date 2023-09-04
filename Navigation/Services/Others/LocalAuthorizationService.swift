//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 05.08.2023.
//

import LocalAuthentication

class LocalAuthorizationService {
    
    static let shared = LocalAuthorizationService() // Singleton Instance
    
    private var context: LAContext
    
    init() {
        self.context = LAContext()
    }
    
    var availableBiometryType: LABiometryType {
        return context.biometryType
    }
    
    func refreshContext() {
        self.context = LAContext()
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        self.refreshContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        authorizationFinished(true, nil)
                    } else {
                        print(authenticationError?.localizedDescription ?? "Failed to authenticate")
                        authorizationFinished(false, authenticationError)
                    }
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            authorizationFinished(false, error)
        }
    }
}


