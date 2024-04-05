//
//  PokemonDetailsViewModel.swift
//  PokemonCatalog
//
//  Created by User on 4/5/24.
//

import Foundation
import SwiftUI

class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    
    private let apiManager = APIManager()

    func loadPokemonDetails(url: String) async {
        do {
            let pokemonDetails = try await apiManager.fetchPokemonDetails(url: url)
            DispatchQueue.main.async {
                self.pokemon = pokemonDetails
            }
        } catch {
            print("Failed to fetch pokemon details: \(error)")
        }
    }
}
