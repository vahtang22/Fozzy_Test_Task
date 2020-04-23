//
//  HomeInteractor.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol: class {
    func getPokemonsList()
    func pokemons() -> [Pokemon]
    func loadMorePokemons()
    func searchPokemon(with name: String)
    func loadPokemons(of type: PokemonType)
}

class HomeInteractor {
    weak var presenter: HomePresenterProtocol!
    
    private let pokemonService = PokemonService()
    
    required init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
}


// MARK: - HomeInteractorProtocol


extension HomeInteractor: HomeInteractorProtocol {
    func loadPokemons(of type: PokemonType) {
        pokemonService.loadPokemonsList(of: type) { [weak self] in
            self?.presenter.updateCollection()
        }
    }
    
    func searchPokemon(with name: String) {
        pokemonService.searchPokemon(with: name) { [weak self] in
            self?.presenter.updateCollection()
        }
    }
    
    func loadMorePokemons() {
        pokemonService.loadPokemonList(loadMore: true) { [weak self] in
            self?.presenter.updateCollection()
        }
    }
    
    func pokemons() -> [Pokemon] {
        return pokemonService.pokemons
    }
    
    func getPokemonsList() {
        pokemonService.loadPokemonList { [weak self] in
            self?.presenter.updateCollection()
        }
    }
}
