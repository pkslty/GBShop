//
//  CartViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import UIKit

protocol CartView {
    func setData(list: [CartListItem])
    func showAlert(_ title: String?,_ message: String?,_ completion: ((UIAlertAction) -> Void)?)
}

struct CartListItem {
    let productName: String
    let quantity: String
    let price: String
    let cost: String
    let photo: String
}

class CartViewController: UIViewController {

    var presenter: CartPresenter?
    var list = [CartListItem]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    @IBOutlet weak var cartLabel: UILabel!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var emptyCartButton: UIButton!
    @IBOutlet weak var payCartButtoon: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.load()
    }

    private func setupView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
        emptyCartButton.addTarget(self, action: #selector(emptyCartButtonPressed), for: .touchDown)
        payCartButtoon.addTarget(self, action: #selector(payCartButtonPressed), for: .touchDown)
    }
    
    @objc private func emptyCartButtonPressed() {
        presenter?.emptyCart(completion: nil)
    }
    
    @objc private func payCartButtonPressed() {
        presenter?.payCart()
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? CartItemCell else { return UITableViewCell() }
        
        let row = indexPath.row
        let productName = list[row].productName
        let quantity = list[row].quantity
        let price = list[row].price
        let cost = list[row].cost
        let photo = list[row].photo
        cell.configure(productName: productName, quantity: quantity, price: price, cost: cost, photo: photo
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.viewWillRemoveFromCart(at: indexPath.row)
        }
    }
}

extension CartViewController: CartView {
    func setData(list: [CartListItem]) {
        self.list = list
    }
    
    func showAlert(_ title: String?,_ message: String?,_ completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        present(alert, animated: true, completion: nil)
    }
}
