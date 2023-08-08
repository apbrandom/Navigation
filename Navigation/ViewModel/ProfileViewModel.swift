//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Вадим Виноградов on 12.05.2023.
//

import UIKit

class ProfileViewModel {
    
    var postData: [Post] {
        return PostStorage.shared.getAllPosts()
    }
    
    let photoData = Photo.make()
    
    var keyboardWillShow: ((CGFloat) -> Void)?
    var keyboardWillHide: (() -> Void)?
    
    init() {
        setupKeyboardObservers()
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        keyboardWillShow?(keyboardHeight ?? 0.0)
    }
    
    @objc private func willHideKeyboard(_ notification: NSNotification) {
        keyboardWillHide?()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func numberOfSection() -> Int {
        2
    }
    
    func numbersOfRow(in section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return postData.count
        default:
            break
        }
        return 0
    }
}
