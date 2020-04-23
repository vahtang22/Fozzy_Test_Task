//
//  SettingsConfigurator.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol SettingsConfiguratorProtocol: class {
    func configure(with viewController: SettingsViewController)
}

class SettingsConfigurator: SettingsConfiguratorProtocol {
    func configure(with viewController: SettingsViewController) {
        let presenter = SettingsPresenter.init(view: viewController)
        let interactor = SettingsInteractor.init(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
