//
//  CartItemCell.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import UIKit

class CartItemCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    func configure(productName: String, quantity: String, price: String, cost: String, photo: String) {
        self.productNameLabel.text = productName
        self.productQuantityLabel.text = quantity
        self.priceLabel.text = price
        self.costLabel.text = cost
        ImageLoader.getImage(from: photo) { [weak self] image in
            guard let self = self else { return }
            self.productPhoto.image = image
        }
    }
    
}
