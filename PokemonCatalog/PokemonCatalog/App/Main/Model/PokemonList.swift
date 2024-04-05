//  PokemonListDTO.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/3/24.
//

import Foundation
import SwiftData

// MARK: - PokemonList

// in order to use Swift Data, your classes need to be final meaning they cannot be overwritten or subclassed
final class PokemonList {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try container.decodeIfPresent(String.self, forKey: .next)
        previous = try container.decodeIfPresent(String.self, forKey: .previous)
        results = try container.decodeIfPresent([Result].self, forKey: .results)
    }
}

extension PokemonList: Decodable {
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - Result
struct Result: Hashable {
    let name: String
    let url: String
}

extension Result: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

