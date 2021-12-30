//
//  SignUpPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 28.12.2021.
//

import UIKit

class SignUpPresenter: UserEditInfoPresentable {
    var view: UserEditInfoView
    
    func load() {
        
    }
    
    func saveChanges() {
        guard view.userName != "", view.password != "", view.email != ""
        else {
            let message = " Username, password and e-mail can't be empty"
            
            view.showAlert("Error", message, nil)
            return
        }
    }
    
    var factory: RequestFactory
    
    init(factory: RequestFactory, view: UserEditInfoView) {
        self.factory = factory
        self.view = view
    }
}
