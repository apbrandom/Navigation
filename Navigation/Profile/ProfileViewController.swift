//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController {
    
    //MARK: - Data
    
    fileprivate let postData = Post.make()
    fileprivate let photoData = Photo.make()
    
    var user: User

        init(user: User) {
            self.user = user
            super.init(nibName: nil, bundle: nil)
            profileTableHeaderView.updateUser(user)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    private lazy var profileTableHeaderView: ProfileTableHeaderView = {
            let headerView = ProfileTableHeaderView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            return headerView
        }()
    
    private lazy var profileTableView: UITableView = {
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
        setupTableView()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    //MARK: - Action
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        profileTableView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        profileTableView.contentInset.bottom = 0.0
    }
    
    //MARK: - Privte
    
    private func setupView() {
        
        #if DEBUG
        view.backgroundColor = .systemBlue
        #else
        view.backgroundColor = .secondarySystemBackground
        #endif

        tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "person"),
            tag: 0
        )
    }
    
    private func setupSubviews() {
        view.addSubview(profileTableView)
        view.addSubview(semiTransparentView)
    }
    
    private func setupTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 500
        

        profileTableView.setAndLayout(headerView: profileTableHeaderView)
        profileTableHeaderView.delegate = self
        
        profileTableView.register(PostsTableCell.self, forCellReuseIdentifier: PostsTableCell.indentifire)
        profileTableView.register(PhotosTableCell.self, forCellReuseIdentifier: PhotosTableCell.indentifire )
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    private func setupConstrains() {
        profileTableView.snp.makeConstraints { make in
          make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        semiTransparentView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if postData.count > 0 {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableCell.indentifire, for: indexPath) as? PhotosTableCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(photoData)
                cell.selectionStyle = .none
                cell.tintColor = .black
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableCell.indentifire, for: indexPath) as? PostsTableCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(postData[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}
//MARK: - Delegates

extension ProfileViewController: UITableViewDelegate {}

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
