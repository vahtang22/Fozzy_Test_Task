//
//  SettingsService.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

enum ColumnOption: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
}

class SettingsService {
    static var numberOfColumnsChanged = NSNotification.Name("NumberOfColumnsChanged")
    
    var options = ColumnOption.allCases
    var selected = ColumnOption.four
    
    func apply(option: ColumnOption) {
        selected = option
        
        UserDefaults.standard.set(option.rawValue, forKey: "numberOfColumns")
        NotificationCenter.default.post(name: SettingsService.numberOfColumnsChanged, object: nil, userInfo: ["number" : selected.rawValue])
    }
}
