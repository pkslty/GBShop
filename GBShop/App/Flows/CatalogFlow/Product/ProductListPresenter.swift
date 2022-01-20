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
    
    private func getList() {
        let request = factory.makeProductsRequestFactory()
        request.getProductsList(page: 1, categoryId: categoryId) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let products = value.products {
                            self.products = products
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
    
    private func setData() {
        view.setData(list: products)
    }
}
