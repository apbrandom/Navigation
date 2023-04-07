//
//  CustomButton.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.02.2023.
//

import UIKit

class CustomButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
}
