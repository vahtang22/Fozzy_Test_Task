//
//  HomePresenter.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: class {
    func configureView()
    func pokemons() -> [Pokemon]
    func updateCollection()
    func loadPokemons()
    func loadMorePokemons()
    func navigateToDetails(of pokemon: Pokemon)
    func searchPokemon(with name: String)
    func loadPokemons(of type: PokemonType)
}

class HomePresenter {
    weak var view: HomeViewProtocol!
    var interactor: HomeInteractorProtocol!
    var router: HomeRouterProtocol!
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
}


// MARK: - HomePresenterProtocol


extension HomePresenter: HomePresenterProtocol {
    func loadPokemons(of type: PokemonType) {
        interactor.loadPokemons(of: type)
    }
    
    func searchPokemon(with name: String) {
        interactor.searchPokemon(with: name)
    }
    
    func loadMorePokemons() {
        interactor.loadMorePokemons()
    }
    
    func navigateToDetails(of pokemon: Pokemon) {
        router.navigateToDetails(of: pokemon)
    }
    
    func loadPokemons() {
        interactor.getPokemonsList()
    }
    
    func updateCollection() {
        view.updateCollection()
    }
    
    func pokemons() -> [Pokemon] {
        return interactor.pokemons()
    }
    
    func configureView() {
        view.configureView()
    }
}
