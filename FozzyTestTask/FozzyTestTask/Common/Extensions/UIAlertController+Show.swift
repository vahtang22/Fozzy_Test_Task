//
//  UIAlertController+Show.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

extension UIAlertController {
    func showOverTop() {
        UIApplication.topViewController()?.present(self, animated: true, completion: nil)
    }
}

