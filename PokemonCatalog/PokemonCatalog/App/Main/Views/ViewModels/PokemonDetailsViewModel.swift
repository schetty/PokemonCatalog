//
//  PokemonDetailsViewModel.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/5/24.
//

import Foundation
import SwiftUI

class PokemonDetailsViewModel: ObservableObject {
    
    @Published var pokemon: Pokemon?
    @Published var displayables: [String: Any] = [:]
    
    func loadPokemonDetails(url: String) async {
        do {
            let pokemonDetails = try await APIManager.shared.fetchPokemonDetails(url: url)
            DispatchQueue.main.async { [self] in
                self.pokemon = pokemonDetails
                self.hashDisplayableData()
            }
        } catch {
            print("Failed to fetch pokemon details: \(error)")
        }
    }
    
    // iterate through values of pokemon object to attain stat data
    private func hashDisplayableData() {
        if let pokemon = pokemon {
            let mirror = Mirror(reflecting: pokemon)
            for statistic in mirror.children {
                if let key = statistic.label {
                    displayables[key] = statistic.value
                }
            }
        }
    }
}
