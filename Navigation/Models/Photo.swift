//
//  Photo.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.02.2023.
//

import Foundation
import UIKit

struct Photo {
    var image = UIImage(named: "")
}

extension Photo {
    static func make() -> [UIImage] {
        let imageNames = [
            "photo_1647",
            "photo_2244",
            "photo_2259",
            "photo_2345",
            "photo_2457",
            "photo_3023",
            "photo_3827",
            "photo_5736",
            "photo_5760",
            "photo_6263",
            "photo_6316",
            "photo_6365",
            "photo_6386",
            "photo_6400",
            "photo_6684",
            "photo_7846",
            "photo_8914",
            "photo_8935",
            "photo_9008",
            "photo_9027",
        ]
        return imageNames.compactMap { UIImage(named: $0) }
    }
}
