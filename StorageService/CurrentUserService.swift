//
//  CurrentUserService.swift
//  StorageService
//
//  Created by Вадим Виноградов on 09.04.2023.
//

import Foundation
import UIKit



class CurrentUserService: UserService {
    
    private let currentUser: User
    
    init(user: User) {
        self.currentUser = user
    }
    
    func getUser(login: String) -> User? {
        return currentUser.login == login ? currentUser : nil
    }
    
}


