//
//  UserService.swift
//  StorageService
//
//  Created by Вадим Виноградов on 10.04.2023.
//

import Foundation

public protocol UserService {
    func getUser(login: String) -> User?
}

public class CurrentUserService: UserService {
    
    private let currentUser: User
    
    public init(user: User) {
        self.currentUser = user
    }
    
    public func getUser(login: String) -> User? {
        return currentUser.login == login ? currentUser : nil
    }
}

public class TestUserService: UserService {
    private let testUser: User
    
    public init(user: User) {
        self.testUser = user
    }
    
    public func getUser(login: String) -> User? {
        return testUser.login == login ? testUser : nil
    }
}
