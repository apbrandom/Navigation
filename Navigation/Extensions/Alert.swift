//
//  Alert.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 13.07.2023.
//

import UIKit

class Alert {
    static func showBasic(title: String, message: String, on vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
