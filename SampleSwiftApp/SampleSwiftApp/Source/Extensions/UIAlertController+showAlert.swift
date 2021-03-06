//
//  UIAlertController+showAlert.swift
//  SampleSwiftApp
//
//  Created by am10 on 2019/01/03.
//  Copyright © 2019年 am10. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   buttonTitle: String,
                   buttonAction: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default) { _ in buttonAction() }
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlert(message: String) {
        showAlert(title: "", message: message, buttonTitle: "OK") { }
    }
}
