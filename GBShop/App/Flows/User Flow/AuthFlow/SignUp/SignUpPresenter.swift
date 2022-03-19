//
//  SignUpPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 28.12.2021.
//

import UIKit

class SignUpPresenter: UserEditInfoPresentable {
    var view: UserEditInfoView
    var factory: RequestFactory
    var coordinator: (Coordinator & UserDetailEditable)?
    var user: User?
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    
    func load() {
        view.setActive()
    }
    
    func saveChanges() {
        guard !view.userName.isEmpty, !view.password.isEmpty, !view.email.isEmpty
        else {
            let message = " Username, password and e-mail can't be empty"
            
            view.showAlert("Error", message, nil)
            return
        }
        user = User(id: UUID(),
                    username: view.userName,
                    name: view.firstName,
                    middleName: nil,
                    lastName: view.lastName,
                    password: view.password,
                    email: view.email,
                    gender: view.gender,
                    creditCardId: nil,
                    bio: view.bio,
                    token: nil,
                    photoUrlString: nil)
        
        let request = factory.makeRegistrationRequestFactory()
        guard let user = user else { return }
        view.setWaiting()
        request.register(user: user) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.view.showAlert("Congratulations!", "New user succesfully registered") {[weak self] _ in
                            guard let self = self, let user = self.user else { return }
                            self.view.setActive()
                            AnalyticService.signUp(userName: user.username,
                                                   name: user.name ?? "",
                                                   lastName: user.lastName ?? "",
                                                   eMail: user.email)
                            self.login()
                        }
                    default:
                        self.view.showAlert("Server error", value.errorMessage ?? "Something goes wrong, try again later.") {[weak self] _ in
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
    
    
    init(factory: RequestFactory, view: UserEditInfoView) {
        self.factory = factory
        self.view = view
    }
    
    private func login() {
        view.setWaiting()
        let userName = view.userName
        let password = view.password
        let request = factory.makeAuthRequestFactory()
        request.login(username: userName, password: password) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.token = value.user?.token ?? ""
                        let user = value.user
                        self.view.setActive()
                        AnalyticService.login(userId: user?.id.uuidString ?? "",
                                              token: self.token ?? "",
                                              eMail: user?.email ?? "")
                        self.coordinator?.presenterDidFinish(with: user)
                    default:
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
}
