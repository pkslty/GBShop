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
        
        registerUser(userId: 123, userName: "someuser", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "1234-5678-9123-4567", bio: "Some biography")
        
        changeUserData(userId: 123, userName: "someuser", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "1234-5678-9123-4567", bio: "Some biography")
        
        logout(userId: 123)
        
    }
    
    func login(userName: String, password: String) {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: userName, password: password) { response in
            switch response.result {
            case .success(let login):
                print("Authentification:")
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func registerUser(userId: Int,
                      userName: String,
                      password: String,
                      email: String,
                      gender: String,
                      creditCard: String,
                      bio: String) {
        let register = requestFactory.makeRegisterRequestFactory()
        register.register(userId: userId, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
            switch response.result {
            case .success(let login):
                print("Registration:")
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func changeUserData(userId: Int,
                      userName: String,
                      password: String,
                      email: String,
                      gender: String,
                      creditCard: String,
                      bio: String) {
        let register = requestFactory.makeRegisterRequestFactory()
        register.changeUserData(userId: userId, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
            switch response.result {
            case .success(let login):
                print("Change User Data:")
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }

    func logout(userId: Int) {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.logout(userId: userId) { response in
            switch response.result {
            case .success(let login):
                print("Authentification:")
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

}

