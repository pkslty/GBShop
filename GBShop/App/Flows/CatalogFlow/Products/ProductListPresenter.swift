//
//  ProductPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 13.01.2022.
//

import Foundation

class ProductListPresenter {
    var view: ProductListView
    var factory: RequestFactory
    var coordinator: Coordinator?
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
                            break
                        }
                    }
                }
            }
        }
        
    }
    
    private func setData() {
        view.setData(list: products)
    }
}
