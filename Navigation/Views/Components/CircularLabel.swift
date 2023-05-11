//
//  CircularLabel.swift
//  Navigation
//
//  Created by Вадим Виноградов on 06.05.2023.
//

import UIKit

class CircularLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
    }
}
