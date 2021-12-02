//
//  ViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 26.11.2021.
//

import UIKit

class ViewController: UIViewController {

    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login(userName: "somebody", password: "mypassword")
        
        let user = User(id: 123, login: "someuser", name: "John", lastname: "Doe", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "somenumber", bio: "bio")
        
        registerUser(user: user)
        
        changeUserData(user: user)
        
        logout(userId: 123)
        
    }
    
    func login(userName: String, password: String) {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: userName, password: password) { response in
            switch response.result {
            case .success(let result):
                print("Authentification:")
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func registerUser(user: User) {
        let register = requestFactory.makeRegisterRequestFactory()
        register.register(user: user) { response in
            switch response.result {
            case .success(let result):
                print("Registration:")
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func changeUserData(user: User) {
        let register = requestFactory.makeRegisterRequestFactory()
        register.changeUserData(user: user) { response in
            switch response.result {
            case .success(let result):
                print("Change User Data:")
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }

    func logout(userId: Int) {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.logout(userId: userId) { response in
            switch response.result {
            case .success(let result):
                print("Authentification:")
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

}

