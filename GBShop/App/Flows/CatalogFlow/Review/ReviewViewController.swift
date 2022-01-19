//
//  ReviewViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 19.01.2022.
//

import UIKit

protocol ReviewView {
    func setTitle(title: String)
    func setProductName(name: String)
    func setaddReviewButtonTitle(title: String)
    func setData(reviews: [ReviewViewItem])
}

struct ReviewViewItem {
    let author: String
    let avatarUrlString: String
    let text: String
    let rating: Int
    var photos: [UIImage]?
}

class ReviewViewController: UIViewController {

    var reviews = [ReviewViewItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    var presenter: ReviewPresenter?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        setupView()
    }

    private func setupView() {
        tableView.register(UINib(nibName: "ReviewListCell", bundle: nil), forCellReuseIdentifier: "ReviewListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewListCell") as? ReviewListCell else { return UITableViewCell() }
        let row = indexPath.row
        let author = reviews[row].author
        let avatarUrlString = reviews[row].avatarUrlString
        let photos = reviews[row].photos
        let rating = reviews[row].rating
        let text = reviews[row].text
        cell.configure(author: author, avatarUrlString: avatarUrlString, photos: photos, rating: rating, text: text)
        
        return cell
    }
    
    
}

extension ReviewViewController: ReviewView {
    func setTitle(title: String) {
        self.title = title
    }
    
    func setProductName(name: String) {
        self.productNameLabel.text = name
    }
    
    func setaddReviewButtonTitle(title: String) {
        self.addReviewButton.setTitle(title, for: .normal)
    }
    
    func setData(reviews: [ReviewViewItem]) {
        self.reviews = reviews
    }
    
    
}
