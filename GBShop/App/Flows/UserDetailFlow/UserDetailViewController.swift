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
}

class UserDetailViewController: UIViewController {
    @IBOutlet weak var avatar: RoundShadowView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailField: UITextField!
    var presenter: UserDetailPresenter?
    
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        presenter?.load()
        

        // Do any additional setup after loading the view.
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

}

extension UserDetailViewController: UserDetailView {
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
