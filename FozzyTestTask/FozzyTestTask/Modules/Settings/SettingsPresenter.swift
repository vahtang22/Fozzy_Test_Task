//
//  SettingsPresenter.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol: class {
    func configureView()
    func options() -> [ColumnOption]
    func selected() -> ColumnOption
    func apply(option: ColumnOption)
    func updateTable()
}

class SettingsPresenter {
    weak var view: SettingsViewProtocol!
    var interactor: SettingsInteractorProtocol!
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func updateTable() {
        view.updateTable()
    }
    
    func options() -> [ColumnOption] {
        return interactor.options()
    }
    
    func selected() -> ColumnOption {
        return interactor.selectedOtion()
    }
    
    func apply(option: ColumnOption) {
        interactor.apply(option: option)
    }
    
    func configureView() {
        view.configureView()
    }
}
