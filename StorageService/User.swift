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
    public var fullName: String = ""
    public var avatar: UIImage
    public var status: String = ""
    
    public init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

extension User {
    public static func createTestUser() -> User {
        return User(
            login: "test",
            fullName: "Cat Tester",
            avatar: UIImage(named: "cat")!,
            status: "Hello, world!"
        )
    }
    
    public static func createCurrentuser() -> User {
        return User(
            login: "user",
            fullName: "Cat Traveler",
            avatar: UIImage(named: "cat")!,
            status: "In an active search for a place")
    }
}
