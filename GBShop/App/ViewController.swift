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
        
        auth(userName: "somebody", password: "mypassword")
        
        registerUser(userId: 123, userName: "someuser", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "1234-5678-9123-4567", bio: "Some biography")
        
        logout(userId: 123)
        
    }
    
    func auth(userName: String, password: String) {
        let auth = requestFactory.makeAuthRequestFatory()
            auth.login(userName: userName, password: password) { response in
                switch response.result {
                case .success(let login):
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
        let register = requestFactory.makeRegisterRequestFatory()
        register.register(userId: userId, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
                switch response.result {
                case .success(let login):
                    print(login)
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
    }

    func logout(userId: Int) {
        let logout = requestFactory.makeLogoutRequestFatory()
        logout.logout(userId: userId) { response in
                switch response.result {
                case .success(let login):
                    print(login)
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
    }

}

