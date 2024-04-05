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
    
    func loadPokemonDetails(url: String) async {
        do {
            let pokemonDetails = try await APIManager.shared.fetchPokemonDetails(url: url)
            DispatchQueue.main.async {
                self.pokemon = pokemonDetails
            }
        } catch {
            print("Failed to fetch pokemon details: \(error)")
        }
    }
}
