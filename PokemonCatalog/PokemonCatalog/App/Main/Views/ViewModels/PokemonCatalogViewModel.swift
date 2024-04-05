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

