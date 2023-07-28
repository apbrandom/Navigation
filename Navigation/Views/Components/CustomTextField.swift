//
//  CustomTextField.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 20.06.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextField() {
        backgroundColor = UIColor.systemGray6
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        autocorrectionType = UITextAutocorrectionType.no
        autocapitalizationType = .none
        keyboardType = UIKeyboardType.default
        clearButtonMode = UITextField.ViewMode.whileEditing
        returnKeyType = UIReturnKeyType.done
        layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
}
