//
//  User.swift
//  StorageService
//
//  Created by Вадим Виноградов on 09.04.2023.
//

import Foundation
import UIKit

public class User {
    var login: String = ""
    var fullName: String = ""
    var avatar: UIImage
    var status: String = ""
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

let currentUser = User(login: "current_user", fullName: "Current User", avatar: UIImage(named: "current_avatar")!, status: "Active")
let currentUserService = CurrentUserService(user: currentUser)
