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
