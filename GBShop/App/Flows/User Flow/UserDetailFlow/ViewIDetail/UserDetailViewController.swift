//
//  UserDetailViewController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 24.12.2021.
//

import UIKit

protocol UserDetailView {
    func setAvatarImage(image: UIImage?)
    func setFullName(fullName: String)
    func setEmail(email: String)
    func setUserInfo(userInfo: String)
}

class UserDetailViewController: UIViewController {
    var presenter: UserDetailPresenter?
    
    @IBOutlet weak var avatar: RoundShadowView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var fullNameField: UITextField!
    
    @IBOutlet weak var UserInfoTextView: UITextView!
    @IBOutlet weak var editInfoButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()

        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchDown)
        editInfoButton.addTarget(self, action: #selector(editInfoButtonPressed), for: .touchDown)
        
        self.avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlert)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.load()
        navigationController?.navigationBar.isHidden = true
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
    
    @objc private func logoutButtonPressed() {
        presenter?.logoutButtonPressed()
    }

    @objc private func editInfoButtonPressed() {
        presenter?.editInfoButtonPressed()
    }
}

extension UserDetailViewController: UserDetailView {
    func setUserInfo(userInfo: String) {
        self.UserInfoTextView.text = userInfo
    }
    
    func setAvatarImage(image: UIImage?) {
        self.avatar.image = image ?? UIImage(systemName: "person")
    }
    
    func setFullName(fullName: String) {
        self.fullNameField.text = fullName
    }
    
    func setEmail(email: String) {
        self.emailField.text = email
    }
    
}

//MARK:- Image Picker
extension UserDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //This is the tap gesture added on my UIImageView.
    

    //Show alert to selected the media source type.
    @objc private func showAlert() {

        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        self.dismiss(animated: true) { [weak self] in

            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            self?.avatar.image = image
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
