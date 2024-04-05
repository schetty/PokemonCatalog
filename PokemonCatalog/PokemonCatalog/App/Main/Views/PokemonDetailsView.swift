//
//  PokemonDetailsView.swift
//  PokemonCatalog
//
//  Created by User on 4/5/24.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @StateObject private var viewModel: PokemonDetailsViewModel = PokemonDetailsViewModel()
    let pokemon: Result
    
    var body: some View {
        VStack {
            if let pokemon = viewModel.pokemon, let name = pokemon.name, let species = pokemon.species, let speciesName = species.name, let weight = pokemon.weight, let height = pokemon.height {
                Text("Name: " + name)
                Text("Species: " + speciesName)
                Text("Weight: " + "\(weight)")
                Text("Height: " + "\(height)")
            }
        }.task {
            await viewModel.loadPokemonDetails(url: pokemon.url)
        }
    }
}

