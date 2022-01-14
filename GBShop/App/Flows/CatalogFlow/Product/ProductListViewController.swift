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
    var collectionView: UICollectionView!
    var list = [Product]() {
        didSet {
            collectionView.reloadData()
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
        setupCollectionView()
        setupSortMenu()
        presenter?.load()
        
        
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        /*collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true*/
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemIndigo
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
