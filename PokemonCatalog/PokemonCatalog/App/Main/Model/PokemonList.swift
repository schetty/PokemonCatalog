//  PokemonListDTO.swift
//  PokemonCatalog
//
//  Created by User on 4/3/24.
//

import Foundation
import SwiftData

@Model
// MARK: - PokemonList
class PokemonList {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]?
    
    init(count: Int, next: String?, previous: String?, results: [Result]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    convenience init(item: PokemonList) {
        self.init(count: item.count,
                  next: item.next,
                  previous: item.previous,
                  results: item.results)
    }
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}

