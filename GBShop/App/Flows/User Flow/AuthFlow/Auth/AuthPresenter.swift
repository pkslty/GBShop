//
//  AuthPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 26.12.2021.
//

import UIKit

class AuthPresenter {
    var view: AuthView
    var factory: RequestFactory
    var coordinator: (Coordinator & SignUppable)?
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    
    init(factory: RequestFactory, view: AuthView) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        view.setActive()
    }
    
    func loginButtonPressed() {
        view.setWaiting()
        let login = view.getLogin()
        let password = view.getPassword()
        let request = factory.makeAuthRequestFactory()
        request.login(userName: login, password: password) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.token = value.user?.token ?? ""
                        let user = value.user
                        self.coordinator?.presenterDidFinish(with: user)
                    default:
                        self.view.showAlert("Error", "Wrong username or password") {[weak self] in
                            guard let self = self else { return }
                            self.view.setActive()
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.view.showAlert("Server error", "Something goes wrong, try again later") {[weak self] in
                        guard let self = self else { return }
                        self.view.setActive()
                    }
                }
            }
        }
    }
    
    func signUpButtonPressed() {
        coordinator?.signUp()
    }
}
