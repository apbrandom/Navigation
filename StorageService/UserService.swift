//
//  UserService.swift
//  StorageService
//
//  Created by Вадим Виноградов on 10.04.2023.
//

import Foundation
import UIKit

public protocol UserService {
    var user: User { get }
}

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

public class CurrentUserService: UserService {
    public var user = User(login: "user", fullName: "Cat Traveler", avatar: UIImage(named: "cat")!, status: "In an active search for a relaxing place")
    public init() {}
}

public class TestUserService: UserService {
    public var user = User(login: "test", fullName: "Cat Tester", avatar: UIImage(named: "cat")!, status: "Hello, world!")
    public init() {}
}
