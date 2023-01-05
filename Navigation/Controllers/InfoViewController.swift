//
//  InfoViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 05.01.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    var buttonAlert = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemBackground
        ButtonAlert()
        self.view.addSubview(buttonAlert)
    }
    
    //MARK: - Methods
    
    fileprivate func ButtonAlert() {
        buttonAlert = UIButton(type: .system)
        buttonAlert = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 45))
        buttonAlert.backgroundColor = UIColor.blue
        buttonAlert.layer.cornerRadius = 10
        buttonAlert.center = self.view.center
        buttonAlert.setTitle("Press me!", for: .normal)
        buttonAlert.addTarget(self, action: #selector(buttonAlertPressed), for: .touchUpInside)
    }
    
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

