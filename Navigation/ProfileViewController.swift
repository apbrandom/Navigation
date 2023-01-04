//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        self.view.backgroundColor = UIColor.blue
        var tabBarItem = UITabBarItem()

        tabBarItem = UITabBarItem(title: "Profile",
                                  image: UIImage(systemName: "person"),
                                  selectedImage: nil)

        self.tabBarItem = tabBarItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
