//
//  CartViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import UIKit

protocol CartView {
    
}

class CartViewController: UIViewController {

    var presenter: CartPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension CartViewController: CartView {
    
}
