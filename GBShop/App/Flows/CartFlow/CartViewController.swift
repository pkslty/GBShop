//
//  CartViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import UIKit

protocol CartView {
    func setData(list: [CartListItem])
}

struct CartListItem {
    let productName: String
    let quantity: Int
    let price: String
    let cost: String
    let photo: String
}

class CartViewController: UIViewController {

    var presenter: CartPresenter?
    var list = [CartListItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var cartLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
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
        let price = list[row].price
        let cost = list[row].cost
        let photo = list[row].photo
        cell.configure(productName: productName, price: price, cost: cost, photo: photo
        )
        return cell
    }
    
    
}

extension CartViewController: CartView {
    func setData(list: [CartListItem]) {
        self.list = list
    }
    
    
}
