//
//  ViewController+Extension.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {
    func presentAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
