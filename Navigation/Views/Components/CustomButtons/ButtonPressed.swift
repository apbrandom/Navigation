//
//  ButtonPressed.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 29.07.2023.
//

import UIKit

class ButtonPressed: UIButton {
    
    var pressed: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        pressed?()
    }
}

