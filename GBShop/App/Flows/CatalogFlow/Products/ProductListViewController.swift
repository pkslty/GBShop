//
//  ProductViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 13.01.2022.
//

import UIKit

protocol ProductListView {
    func setTitle(title: String)
    func setData(list: [ProductViewItem])
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?)
}

struct ProductViewItem {
    let productName: String
    let productDescription: String
    let productPrice: String
    let rating: Int
    let photoUrlString: String
}

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenter?
    var tableView: UITableView!
    var list = [ProductViewItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override init(nibName: String?, bundle: Bundle?) {
        
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSortMenu()
        presenter?.load()
        
        
    }
    
    private func setupTableView() {

        let inset = (tabBarController?.tabBar.frame.height ?? 0) + (navigationController?.navigationBar.frame.height ?? 0)
        self.tableView = UITableView(frame: view.frame)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)
        view.addSubview(tableView)
        
        tableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSortMenu() {
        let sortItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"))
        let rating = UIAction(title: "Sort by rating") { _ in
            self.sortByRating()
        }
        
        let priceUp = UIAction(title: "Cheaper first") { _ in
            self.sortPriceUp()
        }
        
        let priceDown = UIAction(title: "Expensive first") { _ in
            self.sortPriceDown()
        }
        let sortMenu = UIMenu(children: [rating, priceUp, priceDown])
        sortItem.menu = sortMenu
        navigationItem.setRightBarButton(sortItem, animated: false)
        
    }
    
    private func sortByRating() {
        presenter?.sortByRating()
    }
    
    private func sortPriceUp() {
        presenter?.sortPriceUp()
    }
    
    private func sortPriceDown() {
        presenter?.sortPriceDown()
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell") as? ProductListCell else { return UITableViewCell() }
        
        let product = list[indexPath.row]
        
        cell.delegate = self
        cell.configure(productName: product.productName,
                       productImage: product.photoUrlString,
                       productDescription: product.productDescription,
                       productPrice: product.productPrice,
                       productRating: product.rating,
                       tag: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        presenter?.viewDidSelectRow(row: row)
    }
    
}

extension ProductListViewController: ProductListView {
    func setData(list: [ProductViewItem]) {
        self.list = list
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: completion)
    }
}

extension ProductListViewController: ProductListCellDelegate {
    func addToCart(tag: Int, quantity: Int) {
        presenter?.addToCart(row: tag, quantity: quantity)
    }
}
