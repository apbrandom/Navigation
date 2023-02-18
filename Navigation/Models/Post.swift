//
//  Post.swift
//  Navigation
//
//  Created by Вадим Виноградов on 05.01.2023.
//

import UIKit

struct Post {
    var title: String = ""
//    var author: String = ""
    var image: String = ""
//    var likes: Int = 0
//    var views: Int = 0
}

extension Post {
    static func make() -> [Post] {
        [
            Post(title: "Example1", image: "Portugal"),
            Post(title: "Example2", image: "Lissabon"),
            Post(title: "Example3", image: "Bike"),
            Post(title: "Example4", image: "Apple_swift")
        ]
    }
}
