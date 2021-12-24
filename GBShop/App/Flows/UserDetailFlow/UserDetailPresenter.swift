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
    
    init(factory: RequestFactory, view: UserDetailView) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        view.setAvatarImage(image: UIImage(systemName: "person.fill"))
        view.setFullName(fullName: "FirstName SecondName")
        view.setEmail(email: "email@emai.com")
    }
    
}
