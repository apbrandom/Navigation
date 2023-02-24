//
//  Photo.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.02.2023.
//

import Foundation

struct Photo {
    var image: String = ""
}

extension Photo {
    static func make() -> [Photo] {
        [
            Photo(image: "photo_1647"),
            Photo(image: "photo_2244"),
            Photo(image: "photo_2259"),
            Photo(image: "photo_2345"),
            Photo(image: "photo_2457"),
            Photo(image: "photo_3023"),
            Photo(image: "photo_3827"),
            Photo(image: "photo_5736"),
            Photo(image: "photo_5760"),
            Photo(image: "photo_6263"),
            Photo(image: "photo_6316"),
            Photo(image: "photo_6365"),
            Photo(image: "photo_6386"),
            Photo(image: "photo_6400"),
            Photo(image: "photo_6684"),
            Photo(image: "photo_7846"),
            Photo(image: "photo_8914"),
            Photo(image: "photo_8935"),
            Photo(image: "photo_9008"),
            Photo(image: "photo_9027"),
        ]
    }
}
