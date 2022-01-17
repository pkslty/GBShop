//
//  ProductViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 13.01.2022.
//

import UIKit

protocol ProductListView {
    func setTitle(title: String)
    func setData(list: [Product])
}

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenter?
    var tableView: UITableView!
    var list = [Product]() {
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
        
        self.tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        
        /*collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true*/
        
        tableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSortMenu() {
        let sortItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"))
        let rating = UIAction(title: "Sort by rating") { _ in
             
        }
        
        let priceUp = UIAction(title: "Cheaper first") { _ in
            
        }
        
        let priceDown = UIAction(title: "Expensive first") { _ in
            
        }
        let sortMenu = UIMenu(children: [rating, priceUp, priceDown])
        sortItem.menu = sortMenu
        navigationItem.setRightBarButton(sortItem, animated: false)
        
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell") as? ProductListCell else { return UITableViewCell() }
        
        let product = list[indexPath.row]

        
        cell.configure(productName: product.productName,
                       productImage: product.photoUrlString ?? "http://dnk.net.ru/gb_shop/photos/place_holder.png",
                       productDescription: product.productDescription,
                       productPrice: String(product.price))
        
        return cell
    }
    
    
    
}

extension ProductListViewController: ProductListView {
    func setData(list: [Product]) {
        self.list = list
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    
}
