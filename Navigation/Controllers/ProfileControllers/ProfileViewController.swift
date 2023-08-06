//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    weak var coordinator: ProfileCoordinatable?
    var viewModel = ProfileViewModel()
    
    //MARK: - Subviews
    
    private lazy var profileTableHeaderView: ProfileTableHeaderView = {
        let headerView = ProfileTableHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var semiTransparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.isHidden = true
        view.alpha = 0.5
        return view
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstrains()
        keyboardSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.keyboardWillShow = nil
        viewModel.keyboardWillHide = nil
    }
    
    //MARK: - Action
    
    func updateUser(_ user: User) {
        profileTableHeaderView.updateUser(user)
    }
    
    //MARK: - Privte
    
    private func setupView() {
        view.backgroundColor = .darkModeBackground

        setupTableView()
        setupHeaderView()
    }
    
    func setupHeaderView() {
        profileTableView.setAndLayout(headerView: profileTableHeaderView)
        profileTableHeaderView.delegate = self
    }
    
    private func setupSubviews() {
        view.addSubview(profileTableView)
        view.addSubview(semiTransparentView)
    }
    
    
    private func setupConstrains() {
        profileTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        semiTransparentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func keyboardSetup() {
        viewModel.keyboardWillShow = { [weak self] keyboardHeight in
            self?.profileTableView.contentInset.bottom += keyboardHeight
        }
        
        viewModel.keyboardWillHide = { [weak self] in
            self?.profileTableView.contentInset.bottom = 0.0
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension ProfileViewController: ProfileTableHeaderViewDelegate {
    func showSemiTransparentView() {
        semiTransparentView.isHidden = false
        profileTableView.isScrollEnabled = false
    }
    
    func hideSemiTransparentView() {
        semiTransparentView.isHidden = true
        profileTableView.isScrollEnabled = true
    }
}
