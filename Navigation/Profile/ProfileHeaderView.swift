//
//  ProfileHeaderView2.swift
//  Navigation
//
//  Created by Вадим Виноградов on 16.01.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let catView = UIView(frame: CGRect(x: 25, y: 100, width: 150, height: 150))
    
    var avatarImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        setupCatView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }

   private func setupCatView() {
        catView.layer.contents = UIImage(named: "cat")?.cgImage
//      catView.layer.contentsGravity = .resizeAspect
        catView.layer.masksToBounds = true
        catView.layer.cornerRadius = catView.frame.width / 2
        
        catView.layer.borderColor = UIColor.systemBackground.cgColor
        catView.layer.borderWidth = 3
       
       
    }
    
//   private func constraintsCatView() {
//       catView.topAnchor.constraint(equalTo: .safeAreaLayoutGuide.topAnchor)
//    }
    
}


