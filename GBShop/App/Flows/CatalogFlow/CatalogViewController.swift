//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import UIKit

protocol CatalogView {
    var listType: ListTypes { get }
    
    func setTitle(title: String)
    func setData(list: [String])
    func setListType(listType: ListTypes)
    func setListTypeTitle(listType: ListTypes, title: String)
}

enum ListTypes: Int {
    case categories = 0
    case brands = 1
    
    init(_ index: Int) {
        switch index {
        case 0: self = .categories
        default: self = .brands
        }
    }
}

class CatalogViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var listTypeControl: UISegmentedControl!
    var descriptionView: UIView!
   
    var list = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    var presenter: CatalogPresenter?
    
    @IBAction func listTypeControlValueChanged(_ sender: Any) {
        presenter?.listTypeControlValueChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        addFindImage()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let font = UIFont.systemFont(ofSize: 18)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        presenter?.load()
    }

    private func addFindImage() {
        let imageView = UIImageView()
        searchField.leftViewMode = .always
        imageView.image = UIImage(systemName: "magnifyingglass")
        searchField.leftView = imageView
    }
    
    @objc private func showDescription() {
        guard let row = tableView.indexPathForSelectedRow?.row else { return }
        let descriptionViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
        descriptionView = UIView(frame: descriptionViewFrame)

        view.addSubview(descriptionView)

        descriptionView.isHidden = false

        let descriptionLabelFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
        let descriptionLabel = UILabel(frame: descriptionLabelFrame)

        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.text = list[row]

        }
}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row]
        cell.contentConfiguration = content
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDescription))
        cell.addGestureRecognizer(gestureRecognizer)
        return cell
    }
    
}

extension CatalogViewController: CatalogView {
    var listType: ListTypes { ListTypes(listTypeControl.selectedSegmentIndex) }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setData(list: [String]) {
        self.list = list
    }
    
    func setListType(listType: ListTypes) {
        self.listTypeControl.selectedSegmentIndex = listType.rawValue
    }
    
    func setListTypeTitle(listType: ListTypes, title: String) {
        self.listTypeControl.setTitle(title, forSegmentAt: listType.rawValue)
    }
}
