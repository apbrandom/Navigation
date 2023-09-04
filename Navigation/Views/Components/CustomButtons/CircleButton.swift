//
//  CircleButton.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 29.07.2023.
//

import UIKit

class CircleButton: ButtonPressed {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let distanceFromCenter = hypot(point.x - center.x, point.y - center.y)
        return distanceFromCenter <= bounds.size.width / 2
    }
}
