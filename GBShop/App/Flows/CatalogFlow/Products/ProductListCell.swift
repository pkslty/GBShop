//
//  ProductListCell.swift
//  GBShop
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import UIKit

protocol ProductListCellDelegate {
    func addToCart(tag: Int, quantity: Int)
}

class ProductListCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var addToCartButton: UIButton!
    var delegate: ProductListCellDelegate?
    let currencySign = "₽"
    
    @IBAction func addToCartButtonPressed(_ sender: Any) {
    }
    
    func configure(productName: String, productImage: String, productDescription: String, productPrice: String, productRating: Int, productQuantity: Int? = nil, tag: Int) {
        
        self.productName.text = productName
        self.productDescription.text = productDescription
        self.productPrice.text = "\(productPrice) \(currencySign)"
        self.productQuantity.text = String(productQuantity ?? 1)
        self.rating.setRating(rating: productRating)
        ImageLoader.getImage(from: productImage) {[weak self] image in
            guard let self = self else { return }
            self.productImage.image = image
        }
        addToCartButton.tag = tag
        addToCartButton.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    @objc private func addToCartAction() {
        print("Button pressed tag = \(addToCartButton.tag)")
        guard let quantity = Int(productQuantity.text ?? "0"),
        quantity > 0 else { return }
        delegate?.addToCart(tag: addToCartButton.tag, quantity: quantity)
    }
}
