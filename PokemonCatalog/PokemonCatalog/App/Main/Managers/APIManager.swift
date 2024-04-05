//
//  APIManager.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func fetchPokemons(next: String?) async throws -> PokemonList? {
        var url = URL(string: Constants.URLs.pokemonAPIURL)!
        if let nextURL = next {
            url = URL(string: nextURL)!
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let list = try JSONDecoder().decode(PokemonList.self, from: data)
        return list
    }
    
    func fetchPokemonDetails(url: String) async throws -> Pokemon? {
        guard let url = URL(string: url) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let deets = try JSONDecoder().decode(Pokemon.self, from: data)
        return deets
    }
}
