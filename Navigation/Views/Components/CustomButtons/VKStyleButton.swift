//
//  CustomButton.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.02.2023.
//

import UIKit

class VKStyleButton: ButtonPressed {
    
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
    
    override var intrinsicContentSize: CGSize {
            return CGSize(width: 350, height: 50)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViewButton()
    }
    
    func setupViewButton() {
        let image = UIImage(named: "blue_pixel")
        setBackgroundImage(image, for: .normal)
        tintColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
}
