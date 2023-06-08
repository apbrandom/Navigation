//
//  InfoViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 05.01.2023.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HELLLLOOOOO"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alertButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Press me!", for: .normal)
        button.pressed = { self.buttonAlertPressed() }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        alertButton.center = view.center
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            coordinator?.finish()
        }
    }
    
    //MARK: - Action
    
    @objc func buttonAlertPressed() {
        let alertController = UIAlertController(
            title: "Select the id 1-200",
            message: "Please enter your id to receive a message from the server",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            guard let text = alertController.textFields?.first?.text,
                  let enteredId = Int(text),
                  1...200 ~= enteredId
            
            else {
                self.showErrorMessage()
                return
            }
            guard let userUrl = networkService.urlForUser(withId: enteredId) else { return }
            networkService.request(url: userUrl) { answer in
                DispatchQueue.main.async {
                    if let answer = answer {
                        self.titleLabel.text = answer
                    }
                }
            }
        }
        
        alertController.addTextField { (textFiled) in
            textFiled.placeholder = "Enter your message"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func showErrorMessage() {
        let errorAlertController = UIAlertController(
            title: "Error",
            message: "Entered ID is not in the range 1-200 or is not a number.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        errorAlertController.addAction(okAction)
        
        self.present(errorAlertController, animated: true)
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemGray4
    }
    
    private func setupSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(alertButton)
        
        setupLayout()
    }
    
    //MARK: - Layout
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-75)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        alertButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(75)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
}


