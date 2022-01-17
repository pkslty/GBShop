//
//  ProductListCell.swift
//  GBShop
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import UIKit

class ProductListCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var rating: RatingView!
    
    @IBAction func addToCartButtonPressed(_ sender: Any) {
    }
    
    func configure(productName: String, productImage: String, productDescription: String, productPrice: String, productRating: Int, productQuantity: Int? = nil) {
        
        let currencySign = "₽"
        
        self.productName.text = productName
        self.productDescription.text = productDescription
        self.productPrice.text = "\(productPrice) \(currencySign)"
        self.productQuantity.text = String(productQuantity ?? 1)
        self.rating.setRating(rating: productRating)
        ImageLoader.getImage(from: productImage) {[weak self] image in
            guard let self = self else { return }
            self.productImage.image = image
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
