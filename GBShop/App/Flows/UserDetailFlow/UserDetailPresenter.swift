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
    var coordinator: Coordinator?
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    
    init(factory: RequestFactory, view: UserDetailView) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        view.setAvatarImage(image: UIImage(systemName: "person"))
        
        let request = factory.makeRegistrationRequestFactory()
        if let token = token {
            request.getUserData(token: token) { response in
                if let value = response.value {
                    DispatchQueue.main.async {
                        if let user = value.user {
                            self.view.setFullName(fullName: "\(user.name ?? "") \(user.lastname ?? "")")
                            self.view.setEmail(email: user.email)
                            self.view.setUserInfo(userInfo: user.bio ?? "")
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
        coordinator?.presenterDidFinish()
    }
}
