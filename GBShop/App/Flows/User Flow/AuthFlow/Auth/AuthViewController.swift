//
//  AuthViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol AuthView {
    func getLogin() -> String
    func getPassword() -> String
    func setWaiting()
    func setActive()
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?)
}

class AuthViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: AuthPresenter?

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var eyeButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        presenter?.load()
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchDown)
        addEyeButton()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchDown)
        
        let keyboardHideGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(keyboardHideGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    private func addEyeButton() {
        let eyeButtonRect = CGRect(x: 0, y: 0, width: passwordField.frame.height, height: passwordField.frame.height)
        eyeButton = UIButton(frame: eyeButtonRect)
        eyeButton?.imageView?.tintColor = .gray
        eyeButton?.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordField.rightView = eyeButton
        passwordField.rightViewMode = UITextField.ViewMode.always
        
        //Добавлляем gesture recognizer для глаза
        let eyeTapGesture = UITapGestureRecognizer(target: self, action: #selector(showHidePassword))
        eyeButton?.addGestureRecognizer(eyeTapGesture)
    }
    
    @objc private func loginButtonPressed() {
        presenter?.loginButtonPressed()
    }
    
    @objc private func signUpButtonPressed() {
        presenter?.signUpButtonPressed()
    }
    
    @objc private func showHidePassword() {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            eyeButton?.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordField.isSecureTextEntry = true
            eyeButton?.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyBoardbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as!   NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardbSize.height - view.safeAreaInsets.bottom, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
    }
}

extension AuthViewController: AuthView {
    
    func getLogin() -> String {
        loginField.text ?? ""
    }
    
    func getPassword() -> String {
        passwordField.text ?? ""
    }
    
    func setWaiting() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        loginField.isEnabled = false
        passwordField.isEnabled = false
        loginButton.isEnabled = false
        signUpButton.isEnabled = false
    }
    
    func setActive() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        loginField.isEnabled = true
        passwordField.isEnabled = true
        loginButton.isEnabled = true
        signUpButton.isEnabled = true
    }
    
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: completion)
    }
}
