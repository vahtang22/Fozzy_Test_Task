//
//  PokemonService.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import Moya_ObjectMapper

class PokemonService {
    var pokemons: [Pokemon] = []
    
    private var step = 40
    private var offset = 0
    
    func loadPokemonList(loadMore: Bool = false, completion: (() -> Void)?) {
        var pokemonsResult: [Pokemon] = []
        getPokemonsNames (loadMore: loadMore) { [weak self] (pokemons) in
            let group = DispatchGroup()
            for pokemon in pokemons {
                group.enter()
                self?.getPokemonDetails(with: pokemon.name) { pokemon in
                    if let pokemon = pokemon {
                        pokemonsResult.append(pokemon)
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                if loadMore {
                    self?.pokemons += pokemonsResult
                } else {
                    self?.pokemons = pokemonsResult
                }
                completion?()
            }
        }
    }
    
    func loadPokemonsList(of type: PokemonType, completion: (() -> Void)?) {
        var pokemonsResult: [Pokemon] = []
        getPokemons(of: type) { [weak self] pokemons in
            let group = DispatchGroup()
            for pokemon in pokemons {
                group.enter()
                self?.getPokemonDetails(with: pokemon.name) { pokemon in
                    if let pokemon = pokemon {
                        pokemonsResult.append(pokemon)
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                self?.pokemons = pokemonsResult
                completion?()
            }
        }
    }
    
    func searchPokemon(with name: String, completion: (() -> Void)?) {
        getPokemonDetails(with: name.lowercased(), isSearching: true) { pokemon in
            if let pokemon = pokemon {
                self.pokemons = [pokemon]
                completion?()
            } else {
                self.pokemons = []
                completion?()
            }
        }
    }
    
    func getPokemons(of type: PokemonType, completion: (([Pokemon]) -> Void)?) {
        pokemonProvider.request(.typeList(type.rawValue)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.mapObject(PokemonTypesContainer.self)
                    completion?(response.pokemons.map{
                        if let pokemon = $0.pokemon {
                            return pokemon
                        }
                        return Pokemon.empty()
                    })
                } catch {
                    UIApplication.shared.showAlert(with: error.localizedDescription)
                }
            case .failure(let error):
                UIApplication.shared.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func getPokemonsNames(loadMore: Bool = false, completion: (([Pokemon]) -> Void)?) {
        if loadMore {
            offset += step
        } else {
            offset = step
        }
        pokemonProvider.request(.list(offset, 40)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.mapObject(PokemonsContainer.self)
                    completion?(response.results)
                } catch {
                    UIApplication.shared.showAlert(with: error.localizedDescription)
                }
            case .failure(let error):
                UIApplication.shared.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func getPokemonDetails(with name: String, isSearching: Bool = false, completion: ((Pokemon?) -> Void)?) {
        pokemonProvider.request(.details(name)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.mapObject(Pokemon.self)
                    completion?(response)
                } catch {
                    if isSearching {
                        completion?(nil)
                    } else {
                        UIApplication.shared.showAlert(with: error.localizedDescription)
                    }
                }
            case .failure(let error):
                UIApplication.shared.showAlert(with: error.localizedDescription)
            }
        }
    }
}
