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
    var user: UserResult?
    
    init(factory: RequestFactory, view: UserDetailView, with user: UserResult? = nil) {
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
        token = nil
        coordinator?.presenterDidFinish(with: nil)
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
        view.setFullName(fullName: "\(user.name ?? "") \(user.lastname ?? "")")
        view.setEmail(email: user.email)
        view.setUserInfo(userInfo: user.bio ?? "")
    }
}
