//
//  AuthPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 26.12.2021.
//

import UIKit
import Firebase

protocol SignUppable {
    func signUp()
}


class AuthPresenter {
    var view: AuthView
    var factory: RequestFactory
    var coordinator: (Coordinator & SignUppable)?
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    @UserDefault(key: "userId", defaultValue: nil) var userId: String?
    
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
        request.login(username: login, password: password) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.token = value.user?.token ?? ""
                        self.userId = value.user?.id.uuidString ?? ""
                        let user = value.user
                        self.view.setActive()
                        AnalyticService.login(userId: self.userId ?? "", token: self.token ?? "", eMail: user?.email ?? "")
                        self.coordinator?.presenterDidFinish(with: user)
                    default:
                        let userInfo = [
                          NSLocalizedDescriptionKey: NSLocalizedString("Login failed", comment: ""),
                          NSLocalizedFailureReasonErrorKey: NSLocalizedString("Wrong username or password", comment: ""),
                          "login": login,
                          "password": password
                        ]
                        let error = NSError.init(domain: NSCocoaErrorDomain,
                                                 code: -1001,
                                                 userInfo: userInfo)
                        Crashlytics.crashlytics().record(error: error)
                        self.view.showAlert("Error", "Wrong username or password") {[weak self] _ in
                            guard let self = self else { return }
                            self.view.setActive()
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.view.showAlert("Server error", "Something goes wrong, try again later") {[weak self] _ in
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
