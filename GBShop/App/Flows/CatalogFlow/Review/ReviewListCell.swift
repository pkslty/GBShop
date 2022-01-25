//
//  ReviewListCell.swift
//  GBShop
//
//  Created by Denis Kuzmin on 19.01.2022.
//

import UIKit

class ReviewListCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var ratingControl: RatingView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var avatarView: RoundShadowView!
    
    func configure(author: String, avatarUrlString: String, photos: [UIImage]?, rating: Int, text: String) {
        authorLabel.text = author
        ImageLoader.getImage(from: avatarUrlString) {[weak self] image in
            guard let self = self else { return }
            self.avatarView.image = image
        }
        ratingControl.setRating(rating: rating)
        reviewLabel.text = text
        if let photos = photos, !photos.isEmpty {
            setupPhotosView(photos: photos)
        }
    }
    
    private func setupPhotosView(photos: [UIImage]) {
        let photoSize: CGFloat = 120
        photosView.translatesAutoresizingMaskIntoConstraints = false
        photosView.heightAnchor.constraint(equalToConstant: photoSize).isActive = true
        
        let photosScrollView = UIScrollView()
        photosView.addSubview(photosScrollView)
        photosScrollView.translatesAutoresizingMaskIntoConstraints = false
        photosScrollView.leadingAnchor.constraint(equalTo: photosView.leadingAnchor).isActive = true
        photosScrollView.trailingAnchor.constraint(equalTo: photosView.trailingAnchor).isActive = true
        photosScrollView.topAnchor.constraint(equalTo: photosView.topAnchor).isActive = true
        photosScrollView.bottomAnchor.constraint(equalTo: photosView.bottomAnchor).isActive = true
        photosScrollView.heightAnchor.constraint(equalTo: photosView.heightAnchor).isActive = true
        
        let photosViews = photos.compactMap { UIImageView(image: $0) }
        photosViews.forEach { $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: photoSize).isActive = true
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
