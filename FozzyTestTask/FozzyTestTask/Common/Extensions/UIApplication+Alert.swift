//
//  UIApplication+Alert.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

extension UIApplication {
    func showAlert(with message: String) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
        alert.showOverTop()
    }
}
