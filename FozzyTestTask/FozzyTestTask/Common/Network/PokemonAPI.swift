//
//  PokemonAPI.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import Moya


// MARK: - Provider setup


let pokemonProvider = MoyaProvider<PokemonAPI>()


// MARK: - Provider support

public enum PokemonAPI {
    case list(Int, Int)
    case details(String)
    case typeList(String)
}

extension PokemonAPI: TargetType {
    public var baseURL: URL { return URL(string: "https://pokeapi.co/api/v2/")! }
    
    public var path: String {
        switch self {
        case .list(_, _):
            return "pokemon"
        case .details(let name):
            return "pokemon/\(name)"
        case .typeList(let type):
            return "type/\(type)"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .list(let offset, let limit):
            return .requestParameters(parameters: ["offset" : offset, "limit" : limit], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        default:
            return .none
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
