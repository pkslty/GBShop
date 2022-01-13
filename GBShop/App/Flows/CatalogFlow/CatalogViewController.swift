//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import UIKit

protocol CatalogView {
    var listType: ListTypes { get set }
    
    func setTitle(title: String)
    func setData(list: [String])
    func setListType(listType: ListTypes)
    func setListTypeTitle(listType: ListTypes, title: String)
    func setActive()
    func setWaiting()
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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var tableView: UITableView
    @IBOutlet weak var searchField: UITextField!
    var listTypeControl: UISegmentedControl?
    var descriptionView: UIView!
   
    var list = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    var presenter: CatalogPresenter?
    var listType: ListTypes
    
    @IBAction func listTypeControlValueChanged(_ sender: Any) {
        presenter?.listTypeControlValueChanged()
    }
    
    init(nibName: String?, bundle: Bundle?, withListControl: Bool) {
        self.tableView = UITableView()
        if withListControl {
            self.listTypeControl = UISegmentedControl()
        }
        self.listType = .categories
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
 
        presenter?.load()
    }

    private func addFindImage() {
        let imageView = UIImageView()
        searchField.leftViewMode = .always
        imageView.image = UIImage(systemName: "magnifyingglass")
        searchField.leftView = imageView
    }
    
    /*@objc private func showDescription() {
        guard let row = tableView.indexPathForSelectedRow?.row else { return }
        let descriptionViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
        descriptionView = UIView(frame: descriptionViewFrame)

        view.addSubview(descriptionView)

        descriptionView.isHidden = false

        let descriptionLabelFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
        let descriptionLabel = UILabel(frame: descriptionLabelFrame)

        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.text = list[row]
        }*/
    
    private func setupView() {
        setupListTypeControl()
        setupTableView()
        addFindImage()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if let listTypeControl = listTypeControl {
            tableView.topAnchor.constraint(equalTo: listTypeControl.bottomAnchor, constant: 10).isActive = true
        } else {
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10).isActive = true
        }
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupListTypeControl() {
        guard let listTypeControl = listTypeControl else { return }
        listTypeControl.insertSegment(withTitle: nil, at: 0, animated: false)
        listTypeControl.insertSegment(withTitle: nil, at: 1, animated: false)
        
        listTypeControl.selectedSegmentTintColor = .systemIndigo
        
        let valueChangedAction = UIAction { _ in
            self.listType = ListTypes(listTypeControl.selectedSegmentIndex)
            self.presenter?.listTypeControlValueChanged()
        }
        listTypeControl.addAction(valueChangedAction, for: .valueChanged)
        
        view.addSubview(listTypeControl)
        listTypeControl.translatesAutoresizingMaskIntoConstraints = false
        listTypeControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        listTypeControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        listTypeControl.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10).isActive = true
        listTypeControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let font = UIFont.systemFont(ofSize: 18)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.viewDidSelectRow(row: indexPath.row)
    }
}

extension CatalogViewController: CatalogView {
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setData(list: [String]) {
        self.list = list
    }
    
    func setListType(listType: ListTypes) {
        self.listTypeControl?.selectedSegmentIndex = listType.rawValue
        self.listType = listType
    }
    
    func setListTypeTitle(listType: ListTypes, title: String) {
        self.listTypeControl?.setTitle(title, forSegmentAt: listType.rawValue)
    }
    
    func setWaiting() {
        self.listTypeControl?.isEnabled = false
        self.searchField.isEnabled = false
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func setActive() {
        self.listTypeControl?.isEnabled = true
        self.searchField.isEnabled = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
