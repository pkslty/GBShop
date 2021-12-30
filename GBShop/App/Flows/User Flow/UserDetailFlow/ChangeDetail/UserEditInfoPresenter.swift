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
    var user: User?
    
    init(factory: RequestFactory, view: UserEditInfoView, with user: User? = nil) {
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
        view.setWaiting()
        let changedUser = User(id: user.id,
                               username: view.userName,
                               name: view.firstName,
                               middleName: "",
                               lastName: view.lastName,
                               password: view.password,
                               email: view.email,
                               gender: view.gender,
                               creditCardId: "",
                               bio: view.bio,
                               token: token,
                               photoUrlString: "")

        let request = factory.makeRegistrationRequestFactory()
        request.changeUserData(user: changedUser) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    if value.result == 1 {
                        //Temporary
                        self.coordinator?.didSaveUserInfo(with: changedUser)
                    } else {
                        self.view.showAlert("Error", "Error saving user info") {
                            self.view.setActive()
                        }
                    }
                }
            }
        }
    }
    
    private func fillDetails() {
        guard let user = user else { return }
        view.setTitle(title: "Edit User Info")
        view.setUserName(userName: user.username)
        view.setFirstName(firstName: user.name ?? "First Name")
        view.setLastName(lastName: user.lastName ?? "Last Name")
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
