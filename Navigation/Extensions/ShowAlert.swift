//
//  ShowAlert.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 22.06.2023.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
