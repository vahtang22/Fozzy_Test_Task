//
//  HomeRouter.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol HomeRouterProtocol: class {
    func navigateToDetails(of pokemon: Pokemon)
}

class HomeRouter {
    weak var viewController: HomeViewController!
    
    required init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}


// MARK: - HomeRouterProtocol


extension HomeRouter: HomeRouterProtocol {
    func navigateToDetails(of pokemon: Pokemon) {
        let vc = DetailsViewController()
        vc.configurator.configure(with: vc, for: pokemon)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
