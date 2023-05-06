//
//  InfoViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 05.01.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 45))
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.blue
        button.setTitle("Press me!", for: .normal)
        button.addTarget(
            self,
            action: #selector(buttonAlertPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        alertButton.center = view.center
    }
    
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(alertButton)
    }
    
    //MARK: - Action
    
    @objc func buttonAlertPressed() {
        let alertController = UIAlertController(title: "Error", message: "You are pressed the button now", preferredStyle: .alert)
        
        let action0 = UIAlertAction(title: "OK", style: .default)  { (action0) in
            let text = alertController.textFields?.first?.text
            print(text ?? "no text")
        }
        
        alertController.addTextField { (textFiled) in
            textFiled.placeholder = "Enter your message"
            
        }
        
        let action1 = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(action0)
        alertController.addAction(action1)
        
        self.present(alertController, animated: true)
    }
}

