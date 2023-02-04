//
//  LogInViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.02.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var logInSrollView: UIScrollView =  {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .gray
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubview()
        setupConstraint()
    }
    
    //MARK: - Private
    
    private func tuneView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubview() {
        view.addSubview(logInSrollView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            logInSrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInSrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logInSrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logInSrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    


}
