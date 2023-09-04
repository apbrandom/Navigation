//
//  UIColor+Extension.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 01.08.2023.
//

import Foundation
import UIKit

extension UIColor {
    static let myDarkColor: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    static let myLightColor: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    static let myDefaultColor: UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    
    static var darkModeBackground: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.myDarkColor
                } else {
                    return UIColor.myLightColor
                }
            }
        } else {
            return UIColor.myDefaultColor
        }
    }()
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
}


