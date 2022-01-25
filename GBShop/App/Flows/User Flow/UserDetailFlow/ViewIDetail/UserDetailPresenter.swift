//
//  UserDetailPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 24.12.2021.
//

import UIKit

class UserDetailPresenter {
    var view: UserDetailView
    var factory: RequestFactory
    var coordinator: (Coordinator & UserDetailEditable)?
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    @UserDefault(key: "userId", defaultValue: nil) var userId: UUID?
    var user: User?
    
    init(factory: RequestFactory, view: UserDetailView, with user: User? = nil) {
        self.factory = factory
        self.view = view
        self.user = user
    }
    
    func load() {
        view.setAvatarImage(image: UIImage(systemName: "person"))
        
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
            view.setFullName(fullName: "FirstName SecondName")
            view.setEmail(email: "email@emai.com")
        }

    }
    
    func logoutButtonPressed() {
        guard let token = token else { return }
        let request = factory.makeAuthRequestFactory()
        request.logout(token: token) { [weak self] response in
            guard let self = self else { return }
            if let value = response.value {
                DispatchQueue.main.async {
                    if value.result == 1 {
                        self.token = nil
                        self.userId = nil
                        self.coordinator?.presenterDidFinish(with: nil)
                    }
                }
            }
        }
    }
    
    func editInfoButtonPressed() {
        coordinator?.editInfo(of: user)
    }
    
    private func setAvatarImage() {
        ImageLoader.getImage(from: "http://dnk.net.ru/gb_shop/photos/users/en_logo.png") {[weak self] in
            guard let self = self else { return }
            self.view.setAvatarImage(image: $0)
        }
    }
    
    private func fillDetails() {
        guard let user = user else { return }
        setAvatarImage()
        view.setFullName(fullName: "\(user.name ?? "") \(user.lastName ?? "")")
        view.setEmail(email: user.email)
        view.setUserInfo(userInfo: user.bio ?? "")
    }
}
