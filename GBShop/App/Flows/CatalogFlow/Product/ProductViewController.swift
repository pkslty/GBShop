//
//  ProductViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 18.01.2022.
//

import UIKit

protocol ProductView {
    func setTitle(title: String)
    func setProductName(name: String)
    func setPhotos(photos: [UIImage])
    func setDescription(description: String)
    func setPrice(price: String)
    
}

class ProductViewController: UIViewController {
    var presenter: ProductPresenter?

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var photosScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        //setupPhotosView()
        
        presenter?.load()
        
    }

    private func setupConstraints() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
    }

    private func setupPhotosView(photos: [UIImage]) {
        let photosViews = photos.compactMap { UIImageView(image: $0) }
        photosViews.forEach { $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: 376).isActive = true
        }
        let photosStackView = UIStackView(arrangedSubviews: photosViews)

        photosStackView.axis = .horizontal
        photosStackView.distribution = .equalSpacing
        photosStackView.alignment = .fill
        photosStackView.spacing = 0
        photosScrollView.addSubview(photosStackView)
        
        photosStackView.translatesAutoresizingMaskIntoConstraints = false
        photosStackView.leadingAnchor.constraint(equalTo: photosScrollView.leadingAnchor).isActive = true
        photosStackView.trailingAnchor.constraint(equalTo: photosScrollView.trailingAnchor).isActive = true
        photosStackView.topAnchor.constraint(equalTo: photosScrollView.topAnchor).isActive = true
        photosStackView.bottomAnchor.constraint(equalTo: photosScrollView.bottomAnchor).isActive = true
        photosStackView.heightAnchor.constraint(equalTo: photosView.heightAnchor).isActive = true
        
        
    }

}

extension ProductViewController: ProductView {
    func setTitle(title: String) {
        self.title = title
    }
    
    func setProductName(name: String) {
        productNameLabel.text = name
    }
    
    func setPhotos(photos: [UIImage]) {
        setupPhotosView(photos: photos)
    }
    
    func setDescription(description: String) {
        productDescriptionLabel.text = description
    }
    
    func setPrice(price: String) {
        
    }
    
    
}
