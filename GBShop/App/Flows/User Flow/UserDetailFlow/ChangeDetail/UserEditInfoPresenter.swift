//
//  UserEditInfoPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 28.12.2021.
//

import UIKit

protocol UserEditInfoPresentable {
    func load()
    func saveChanges()
}

class UserEditInfoPresenter: UserEditInfoPresentable {
    var view: UserEditInfoView
    var factory: RequestFactory
    var coordinator: (Coordinator & UserDetailEditable)?
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    var user: UserResult?
    
    init(factory: RequestFactory, view: UserEditInfoView, with user: UserResult? = nil) {
        self.factory = factory
        self.view = view
        self.user = user
    }
    
    func load() {
        
        guard user == nil else {
            fillDetails()
            return
        }
        
        let request = factory.makeRegistrationRequestFactory()
        if let token = token {
            request.getUserData(token: token) { response in
                if let value = response.value {
                    DispatchQueue.main.async {
                        if let user = value.user {
                            self.user = user
                            self.fillDetails()
                        }
                    }
                }
            }
        }
        else {
            view.showAlert("Error", "User data missed\nTry sign out and sign in", nil)
        }
        

    }
    
    func saveChanges() {
        guard let user = user else { return }

        let changedUser = User(id: user.id,
                               login: view.userName,
                               name: view.firstName,
                               lastname: view.lastName,
                               password: view.password,
                               email: view.email,
                               gender: view.gender,
                               creditCard: "",
                               bio: view.bio)
        let request = factory.makeRegistrationRequestFactory()
        request.changeUserData(user: changedUser) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    if value.result == 1 {
                        //Temporary
                        self.coordinator?.didSaveUserInfo(with: changedUser)
                    } else {
                        self.view.showAlert("Error", "Error saving user info", nil)
                    }
                }
            }
        }
    }
    
    private func fillDetails() {
        guard let user = user else { return }
        view.setTitle(title: "Edit User Info")
        view.setUserName(userName: user.login)
        view.setFirstName(firstName: user.name ?? "First Name")
        view.setLastName(lastName: user.lastname ?? "Last Name")
        view.setEmail(email: user.email)
        view.setBio(bio: user.bio ?? "Add something about yourself")
        if let gender = user.gender {
            switch gender {
            case "m":
                view.setGender(gender: .male)
            case "f":
                view.setGender(gender: .female)
            default:
                view.setGender(gender: .other)
            }
        }
    }
}
