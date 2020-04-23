//
//  Pokemon.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import ObjectMapper

class Pokemon: Mappable {
    var name = ""
    var front_default = ""
    var abilities: [Ability] = []
    var weight = 0
    var height = 0
    var base_experience = 0
    var types: [Type] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        front_default <- map["sprites.front_default"]
        abilities <- map["abilities"]
        weight <- map["weight"]
        height <- map["height"]
        base_experience <- map["base_experience"]
        types <- map["types"]
    }
    
    static func empty() -> Pokemon {
        return Pokemon.init(JSONString: "")!
    }
}

class Ability: Mappable {
    var name = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["ability.name"]
    }
}

class Type: Mappable {
    var name = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["type.name"]
    }
}

