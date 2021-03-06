//
//  ProductPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 13.01.2022.
//

import Foundation

protocol ProductSelectable {
    func productListDidSelectProduct(productId: UUID)
}

class ProductListPresenter {
    var view: ProductListView
    var factory: RequestFactory
    var coordinator: (Coordinator & ProductSelectable & CartAddable)?
    var category: String
    var categoryId: UUID
    var products = [Product]() {
        didSet {
            setData()
        }
    }

    
    init(factory: RequestFactory, view: ProductListView, categoryId: UUID?, categoryName: String?) {
        self.factory = factory
        self.view = view
        self.category = categoryName ?? "Products"
        self.categoryId = categoryId ?? UUID()
    }
    
    func load() {
        view.setTitle(title: category)
        getList()
    }
    
    func sortByRating() {
        products = products.sorted { $0.rating > $1.rating }
    }
    
    func sortPriceUp() {
        products = products.sorted { $0.price < $1.price }
    }
    
    func sortPriceDown() {
        products = products.sorted { $0.price > $1.price }
    }
    
    func viewDidSelectRow(row: Int) {
        let productId = products[row].productId
        coordinator?.productListDidSelectProduct(productId: productId)
    }
    
    func addToCart(row: Int, quantity: Int) {
        guard row >= 0 && row < products.count else { return }
        let completion = { [weak self] in
            guard let self = self else { return }
            self.view.showAlert("Success!", "Product succesfully added to Cart", nil)
        }
        let onError: (String?) -> Void = {[weak self] errorMessage in
            guard let self = self else { return }
            self.view.showAlert("Error!", errorMessage , nil)
        }
        let productId = products[row].productId
        let cartAction = CartAction(action: .addToCart,
                                    productId: productId,
                                    quantity: quantity,
                                    completion: completion,
                                    onError: onError)
        coordinator?.addToCart(action: cartAction)
    }
    
    private func getList() {
        let request = factory.makeProductsRequestFactory()
        request.getProductsList(page: 1, categoryId: categoryId) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let products = value.products {
                            self.products = products
                            self.getPhotos()
                        }
                        //self.view.setActive()
                    default:
                        //self.view.setActive()
                        break
                    }
                }
            }
        }
    }
    
    private func getPhotos() {
        let request = factory.makeProductsRequestFactory()
        guard products.count > 0 else { return }
        for counter in 0 ... products.count - 1 {
            request.getProductPhotos(productId: products[counter].productId) { response in
                if let value = response.value {
                    DispatchQueue.main.async {
                        switch value.result {
                        case 1:
                            if let photoUrlString = value.photos?.first?.urlString {
                                self.products[counter].photoUrlString = photoUrlString
                            }
                        default:
                            self.products[counter].photoUrlString = "http://dnk.net.ru/gb_shop/photos/place_holder.png"
                        }
                    }
                }
            }
        }
        
    }
    
    private func setData() {
        let viewList = products.map { ProductViewItem(productName: $0.productName,
                                               productDescription: $0.productDescription,
                                               productPrice: String($0.price),
                                               rating: $0.rating,
                                               photoUrlString: $0.photoUrlString ?? "http://dnk.net.ru/gb_shop/photos/place_holder.png") }
        view.setData(list: viewList)
    }
}
