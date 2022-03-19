//
//  CatalogCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import UIKit

class CatalogCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var type: CoordinatorType = .catalogCoordinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with data: Any? = nil) {
        let viewController = CatalogViewController(nibName: "CatalogViewController", bundle: nil, withListControl: true)
        let factory = RequestFactory()
        let catalogPresenter = CatalogPresenter(factory: factory, view: viewController)
        catalogPresenter.coordinator = self
        viewController.presenter = catalogPresenter
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
        guard let data = data as? CatalogFinishData else { return }
        if let brandId = data.brandId, data.categoryId == nil {
            let viewController = CatalogViewController(nibName: "CatalogViewController", bundle: nil, withListControl: false)
            let factory = RequestFactory()
            let catalogPresenter = CatalogPresenter(factory: factory, view: viewController, brandId: brandId)
            catalogPresenter.coordinator = self
            viewController.presenter = catalogPresenter
            navigationController.pushViewController(viewController, animated: true)
        } else {
            let viewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
            let factory = RequestFactory()
            let productListPresenter = ProductListPresenter(factory: factory, view: viewController, categoryId: data.categoryId, categoryName: data.categoryName)
            productListPresenter.coordinator = self
            viewController.presenter = productListPresenter
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
}

extension CatalogCoordinator: ProductSelectable {
    func productListDidSelectProduct(productId: UUID) {
        let viewController = ProductViewController(nibName: "ProductView", bundle: nil)
        let factory = RequestFactory()
        let productPresenter = ProductPresenter(factory: factory, view: viewController, productId: productId)
        productPresenter.coordinator = self
        viewController.presenter = productPresenter
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CatalogCoordinator: ReviewShowable {
    func showReviews(productId: UUID) {
        let viewController = ReviewViewController(nibName: "ReviewView", bundle: nil)
        let factory = RequestFactory()
        let reviewPresenter = ReviewPresenter(factory: factory, view: viewController, productId: productId)
        reviewPresenter.coordinator = self
        viewController.presenter = reviewPresenter
        navigationController.pushViewController(viewController, animated: true)
    }
}
    
extension CatalogCoordinator: ReviewAddable {
        func addReview(productId: UUID) {
            let viewController = AddReviewViewController(nibName: "AddReviewView", bundle: nil)
            let factory = RequestFactory()
            let addReviewPresenter = AddReviewPresenter(factory: factory, view: viewController, productId: productId)
            addReviewPresenter.coordinator = self
            viewController.presenter = addReviewPresenter
            navigationController.present(viewController, animated: true, completion: nil)
        }
}

extension CatalogCoordinator: CartAddable {
    func addToCart(action: CartAction) {
        parentCoordinator?.childDidFinish(self, with: action)
    }
}
