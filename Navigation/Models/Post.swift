//
//  Post.swift
//  Navigation
//
//  Created by Вадим Виноградов on 05.01.2023.
//

import UIKit

public struct Post {
    public var description: String
    public var author: String
    public var image: UIImage?
    public var likes: Int
    public let views: Int
}

extension Post {
   public static func make() -> [Post] {
        [
            Post(
                description: "Португалия Wiki",
                author: "Alex",
                image: UIImage(named: "Portugal"),
                likes: 347,
                views: 1679
            ),
            
            Post(
                description: "Путишествие в Лиссабон",
                author: "Alex.",
                image: UIImage(named: "Lissabon"),
                likes: 234,
                views: 1345
            ),
            
            Post(
                description: "Увлекательное путешествие по Европе на велосипеде",
                author: "Mike",
                image: UIImage(named: "Bike"),
                likes: 211,
                views: 800
            ),
            
            Post(
                description: "Язык программирования Swift",
                author: "Bruno",
                image: UIImage(named: "Apple_swift"),
                likes: 47,
                views: 765
            )
        ]
    }
}
