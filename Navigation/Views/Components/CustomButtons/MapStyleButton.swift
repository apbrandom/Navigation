//
//  MapStyleButton.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 30.07.2023.
//

import UIKit

enum SystemImageName: String {
    case flagCheckeredCircle = "flag.checkered.circle"
    case locationCircle = "location.circle"
    case square3layers3dtopfilled = "square.3.layers.3d.top.filled"
    case square3layers3dmiddlefilled = "square.3.layers.3d.middle.filled"
    case square3layers3dbottomfilled = "square.3.layers.3d.bottom.filled"
}

enum MapConfigurationState {
    case state1
    case state2
    case state3
}

class MapStyleButton: CircleButton {
    
    var imageSystemName: SystemImageName? {
        didSet {
            updateImage()
        }
    }
    
    var isActivated: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViewButton()
    }
    
    private func setupViewButton() {
        tintColor = .systemGray6
        imageView?.contentMode = .scaleAspectFill
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
    }
    
    private func updateImage() {
        if let name = imageSystemName, let image = UIImage(systemName: name.rawValue) {
            let tintedImage = image.withTintColor(isActivated ? .systemOrange : .systemGray3, renderingMode: .alwaysOriginal)
            setImage(tintedImage, for: .normal)
        }
    }
}
