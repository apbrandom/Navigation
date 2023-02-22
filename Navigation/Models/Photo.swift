//
//  Photo.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.02.2023.
//

import Foundation

struct Photo {
    var name: String = ""
}

extension Photo {
    static func make() -> [Photo] {
        [
            Photo(name: "photo_1647"),
            Photo(name: "photo_2244"),
            Photo(name: "photo_2259"),
            Photo(name: "photo_2345"),
            Photo(name: "photo_2457"),
            Photo(name: "photo_3023"),
            Photo(name: "photo_3827"),
            Photo(name: "photo_5736"),
            Photo(name: "photo_5760"),
            Photo(name: "photo_6263"),
            Photo(name: "photo_6316"),
            Photo(name: "photo_6365"),
            Photo(name: "photo_6386"),
            Photo(name: "photo_6400"),
            Photo(name: "photo_6684"),
            Photo(name: "photo_7846"),
            Photo(name: "photo_8914"),
            Photo(name: "photo_8935"),
            Photo(name: "photo_9008"),
            Photo(name: "photo_9027"),
        ]
    }
}
