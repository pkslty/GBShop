//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import Foundation

struct CatalogFinishData {
    let brandId: UUID?
    let categoryId: UUID?
}

class CatalogPresenter {
    var view: CatalogView
    var factory: RequestFactory
    var coordinator: Coordinator?
    var brandId: UUID?
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
    
    init(factory: RequestFactory, view: CatalogView, brandId: UUID? = nil) {
        self.factory = factory
        self.view = view
        self.brandId = brandId
    }
    
    func load() {
        view.setListType(listType: .categories)
        view.setListTypeTitle(listType: .categories, title: "Categories")
        view.setListTypeTitle(listType: .brands, title: "Brands")
        getTitle()
        getLists()
    }
    
    func listTypeControlValueChanged() {
        setData()
    }
    
    func viewDidSelectRow(row: Int) {
        var categoryId: UUID?
        var brandId: UUID?
        if view.listType == .categories {
            categoryId = categories[row].id
            brandId = self.brandId
        } else {
            categoryId = nil
            brandId = brands[row].id
        }
        let catalogFinishData = CatalogFinishData(brandId: brandId,
                                                  categoryId: categoryId)
        coordinator?.presenterDidFinish(with: catalogFinishData)
    }
    
    private func getLists() {
        view.setWaiting()
        if let brandId = brandId {
            let request = factory.makeProductsRequestFactory()
            request.getBrandCategories(brandId: brandId) { response in
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
        } else {
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
        
    }
    
    private func getTitle() {
        guard let brandId = brandId else {
            view.setTitle(title: "Catalog")
            return
        }
        let request = factory.makeProductsRequestFactory()
        request.getBrandById(brandId: brandId) {response in
            if let value = response.value {
                DispatchQueue.main.async {
                    let title = value.brand?.name
                    self.view.setTitle(title: title ?? "Catalog")
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
