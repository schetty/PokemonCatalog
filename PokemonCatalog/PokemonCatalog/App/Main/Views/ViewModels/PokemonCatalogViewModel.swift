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
    var loadedPokemons: [Result] = []
    
    var filteredPokemons: [Result]? {
        if searchText.isEmpty {
            return loadedPokemons
        } else {
            return loadedPokemons.filter { $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func loadPokemons(next: String? = nil) async {
        do {
            let pokemonList = try await APIManager.shared.fetchPokemons(next: next)
            await MainActor.run {
                self.pokemonList = pokemonList
                self.loadedPokemons += pokemonList?.results ?? []
            }
        } catch {
            print("Failed to fetch pokemons: \(error)")
        }
    }

    
    func loadMorePokemons(next: String) async {
        await loadPokemons(next: next)
      }
}

