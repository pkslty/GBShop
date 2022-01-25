//
//  AddReviewViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import UIKit

protocol AddReviewView {
    var review: String { get }
    var rating: Int { get }
    func setProductName(name: String)
    func close()
    func showAlert(_ title: String?,_ message: String?,_ completion: ((UIAlertAction) -> Void)?)
}

class AddReviewViewController: UIViewController {
    var presenter: AddReviewPresenter?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var ratingControl: RatingView!
    @IBOutlet weak var reviewField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        addReviewButton.addTarget(self, action: #selector(addReviewButtonPressed), for: .touchDown)
    }
    
    @objc private func addReviewButtonPressed() {
        presenter?.addReviewButtonPressed()
    }
}

extension AddReviewViewController: AddReviewView {
    var review: String {
        return reviewField.text ?? ""
    }
    
    var rating: Int {
        return ratingControl.rating
    }
    
    
    func setProductName(name: String) {
        productNameLabel.text = name
    }
    
    func close() {
        presenter = nil
        dismiss(animated: true)
    }
    
    func showAlert(_ title: String?,_ message: String?,_ completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        present(alert, animated: true, completion: nil)
    }
}
