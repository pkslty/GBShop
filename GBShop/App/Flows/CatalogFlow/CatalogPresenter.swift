//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import Foundation

class CatalogPresenter {
    var view: CatalogView
    var factory: RequestFactory
    var coordinator: Coordinator?
    var categories = [ListItem]() {
        didSet {
            setData()
        }
    }
    var brands = [ListItem]() {
        didSet {
            setData()
        }
    }
    
    init(factory: RequestFactory, view: CatalogView, with brand: UUID? = nil) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        view.setListType(listType: .categories)
        view.setListTypeTitle(listType: .categories, title: "Categories")
        view.setListTypeTitle(listType: .brands, title: "Brands")
        view.setTitle(title: "Catalog")
        getLists()
    }
    
    func listTypeControlValueChanged() {
        setData()
    }
    
    private func getLists() {
        view.setWaiting()
        let request = factory.makeProductsRequestFactory()
        request.getCategories { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let items = value.items {
                            self.categories = items
                            
                        }
                        self.view.setActive()
                        //self.coordinator?.presenterDidFinish(with: user)
                    default:
                        self.view.setActive()
                    }
                }
            }
        }
        request.getBrands { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let items = value.items {
                            self.brands = items
                        }
                        self.view.setActive()
                    default:
                        self.view.setActive()
                    }
                }
            }
        }
    }
    
    private func setData() {
        switch view.listType {
        case .categories:
            view.setData(list: categories.map { $0.name }
                            .sorted(by: <))
        case .brands:
            view.setData(list: brands.map { $0.name }
                            .sorted(by: <))
        }
    }
    
}
