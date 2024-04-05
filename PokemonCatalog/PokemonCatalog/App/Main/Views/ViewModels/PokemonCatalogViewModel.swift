//
//  PokemonCatalogViewModel.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: PokemonList?
    @Published var searchText = ""
    private let apiManager = APIManager()
    
    var filteredPokemons: [Result]? {
        if searchText.isEmpty {
            return pokemonList?.results
        } else {
            guard let results = pokemonList?.results else { return [] }
            return results.filter { $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func loadPokemons(offset: Int? = nil, limit: Int? = nil) async {
        do {
            let pokemonList = try await apiManager.fetchPokemons(offset: offset, limit: limit)
            DispatchQueue.main.async {
                self.pokemonList = pokemonList
            }
        } catch {
            print("Failed to fetch pokemons: \(error)")
        }
    }
}

