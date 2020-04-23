//
//  HomeConfigurator.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

enum PokemonType: String {
    case fighting
    case flying
    case poison
    case ground
}

protocol HomeConfiguratorProtocol: class {
    func configure(with viewController: HomeViewController)
    func configure(with viewController: HomeViewController, for type: PokemonType)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    private var type: PokemonType?
    
    func configure(with viewController: HomeViewController, for type: PokemonType) {
        self.type = type
        
        let presenter = HomePresenter.init(view: viewController)
        let interactor = HomeInteractor.init(presenter: presenter)
        let router = HomeRouter.init(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    func configure(with viewController: HomeViewController) {
        let presenter = HomePresenter.init(view: viewController)
        let interactor = HomeInteractor.init(presenter: presenter)
        let router = HomeRouter.init(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    func pokemonType() -> PokemonType? {
        return type
    }
}
