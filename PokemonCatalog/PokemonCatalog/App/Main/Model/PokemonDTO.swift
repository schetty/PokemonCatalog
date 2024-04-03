//
//  PokemonDTO.swift
//  PokemonCatalog
//
//  Created by User on 4/3/24.
//

import Foundation

// MARK: - PokemonDTO:  Data Transfer Object
struct PokemonDTO: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}

