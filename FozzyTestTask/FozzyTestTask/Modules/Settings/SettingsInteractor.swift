//
//  SettingsInteractor.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol SettingsInteractorProtocol: class {
    func apply(option: ColumnOption)
    func selectedOtion() -> ColumnOption
    func options() -> [ColumnOption]
}

class SettingsInteractor {
    weak var presenter: SettingsPresenterProtocol!
    
    private let settingsService = SettingsService()
    
    required init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SettingsInteractor: SettingsInteractorProtocol {
    func selectedOtion() -> ColumnOption {
        return settingsService.selected
    }
    
    func options() -> [ColumnOption] {
        return settingsService.options
    }
    
    func apply(option: ColumnOption) {
        settingsService.apply(option: option)
        presenter.updateTable()
    }
}
