//
//  UserDetailViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 24.12.2021.
//

import UIKit

protocol UserDetailView {
    func setAvatarImage(image: UIImage?)
    func setFullName(fullName: String)
    func setEmail(email: String)
    func setUserInfo(userInfo: String)
}

class UserDetailViewController: UIViewController {
    var presenter: UserDetailPresenter?
    
    @IBOutlet weak var avatar: RoundShadowView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var fullNameField: UITextField!
    
    @IBOutlet weak var UserInfoTextView: UITextView!
    @IBOutlet weak var editInfoButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        presenter?.load()
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchDown)
        editInfoButton.addTarget(self, action: #selector(editInfoButtonPressed), for: .touchDown)
    }

    private func setupConstraints() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    @objc private func logoutButtonPressed() {
        presenter?.logoutButtonPressed()
    }

    @objc private func editInfoButtonPressed() {
        presenter?.editInfoButtonPressed()
    }
}

extension UserDetailViewController: UserDetailView {
    func setUserInfo(userInfo: String) {
        self.UserInfoTextView.text = userInfo
    }
    
    func setAvatarImage(image: UIImage?) {
        self.avatar.image = image ?? UIImage(systemName: "person")
    }
    
    func setFullName(fullName: String) {
        self.fullNameField.text = fullName
    }
    
    func setEmail(email: String) {
        self.emailField.text = email
    }
}
