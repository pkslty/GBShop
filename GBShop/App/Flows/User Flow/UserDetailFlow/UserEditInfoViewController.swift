//
//  UserEditInfoViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 27.12.2021.
//

import UIKit

protocol UserEditInfoView {
    func setTitle(title: String)
    func setUserName(userName: String)
    func setFirstName(firstName: String)
    func setLastName(lastName: String)
    func setEmail(email: String)
    func setGender(gender: Gender)
    func setPassword(password: String)
    func setRepeatPassword(password: String)
    func setBio(bio: String)
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?)
}

enum ViewRole {
    case editInfo
    case register
}
enum Gender: Int {
    case male = 0
    case female = 2
    case other = 1
}

class UserEditInfoViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var passwordRepeatField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    let role: ViewRole
    var presenter: UserEditInfoPresenter?
    
    init(role: ViewRole) {
        self.role = role
        super.init(nibName: "UserEditInfoView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        presenter?.load()
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

extension UserEditInfoViewController: UserEditInfoView {
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setUserName(userName: String) {
        usernameField.text = userName
    }
    
    func setFirstName(firstName: String) {
        firstNameField.text = firstName
    }
    
    func setLastName(lastName: String) {
        lastNameField.text = lastName
    }
    
    func setEmail(email: String) {
        emailField.text = email
    }
    
    func setGender(gender: Gender) {
        genderSegment.selectedSegmentIndex = gender.rawValue
    }
    
    func setPassword(password: String) {
        passwordField.text = password
    }
    
    func setRepeatPassword(password: String) {
        passwordRepeatField.text = password
    }
    
    func setBio(bio: String) {
        bioText.text = bio
    }
    
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: completion)
    }
}

