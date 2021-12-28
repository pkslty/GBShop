//
//  ShowAlert.swift
//  GBShop
//
//  Created by Denis Kuzmin on 28.12.2021.
//

import UIKit

protocol ShowAlertable {
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?)
}

/*extension ShowAlertable {
    func showAlert(_ title: String?,_ message: String?,_ completion: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                     message: message,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: completion)
    }
}*/
