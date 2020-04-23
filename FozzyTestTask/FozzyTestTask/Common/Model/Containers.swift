//
//  Containers.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import ObjectMapper

class PokemonsContainer: Mappable {
    var results: [Pokemon] = []
    var next: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        next <- map["next"]
    }
}

class PokemonTypesContainer: Mappable {
    var pokemons: [PokemonTypeInnerContainer] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        pokemons <- map["pokemon"]
    }
}

class PokemonTypeInnerContainer: Mappable {
    var pokemon: Pokemon?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        pokemon <- map["pokemon"]
    }
}
