//
//  UserDetailPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 24.12.2021.
//

import UIKit

class UserDetailPresenter {
    var view: UserDetailView
    
    init(view: UserDetailView) {
        self.view = view
    }
    
    func load() {
        view.setAvatarImage(image: UIImage(systemName: "person.fill"))
        view.setFullName(fullName: "FirstName SecondName")
        view.setEmail(email: "email@emai.com")
    }
    
}
