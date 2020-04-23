//
//  DetailsPresenter.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol: class {
    func configureView(for model: Pokemon)
}

class DetailsPresenter {
    weak var view: DetailsViewProtocol!
    
    required init(view: DetailsViewProtocol) {
        self.view = view
    }
}


// MARK: - DetailsPresenterProtocol


extension DetailsPresenter: DetailsPresenterProtocol {
    func configureView(for model: Pokemon) {
        view.configureView(for: model)
        view.configureTableView()
    }
}
