//
//  DetailsConfigurator.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol DetailsConfiguratorProtocol: class {
    func configure(with viewController: DetailsViewController, for model: Pokemon)
    func pokemon() -> Pokemon?
}

class DetailsConfigurator: DetailsConfiguratorProtocol {
    private var pokemonModel: Pokemon?
    
    func configure(with viewController: DetailsViewController, for model: Pokemon) {
        self.pokemonModel = model
        
        let presenter = DetailsPresenter.init(view: viewController)
        viewController.presenter = presenter
        viewController.presenter.configureView(for: model)
    }
    
    func pokemon() -> Pokemon? {
        return pokemonModel
    }
}
