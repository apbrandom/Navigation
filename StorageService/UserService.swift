//
//  UserService.swift
//  StorageService
//
//  Created by Вадим Виноградов on 10.04.2023.
//

import Foundation

public protocol UserService {
    var user: User { get }
    var password: String { get }
    
    func checkLogin(login: String, password: String) -> User?
}

extension UserService {
    public func checkLogin(login: String, password: String) -> User? {
        return login == user.login && password == self.password ? user : nil
    }
}

    
