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
    func setRating(rating: Int)
    func setReviewsText(text: String)
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?)
}

class ProductViewController: UIViewController {
    var presenter: ProductPresenter?

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var photosScrollView: UIScrollView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var ratingControl: RatingView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupView()
        
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

    private func setupView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapReviewsControl))
        reviewsView.addGestureRecognizer(tapGestureRecognizer)
        reviewsView.subviews.forEach { $0.addGestureRecognizer(tapGestureRecognizer) }
        addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchDown)
    }
    
    @objc private func didTapReviewsControl() {
        presenter?.showReviews()
    }
    
    @objc private func addToCartButtonPressed() {
        presenter?.addToCart()
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
        productPriceLabel.text = price
    }
    
    func setRating(rating: Int) {
        ratingControl.setRating(rating: rating)
    }
    
    func setReviewsText(text: String) {
        reviewsLabel.text = text
    }
    
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: completion)
    }
}
