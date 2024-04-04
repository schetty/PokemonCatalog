//
//  ContentView.swift
//  PokemonCatalog
//
//  Created by User on 4/3/24.
//

import SwiftUI

struct PokemonCatalogView: View {
    
    @StateObject private var viewModel: PokemonViewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            if let pokemons = viewModel.pokemonList?.results {
                List(pokemons, id: \.self) { pokemon in
                    Text(pokemon.name)
                }
            } else {
                Text("No pokemons :(")
            }
        }.onAppear(perform: {
            Task {
                await viewModel.loadPokemons()
            }
        })
    }
}

#Preview {
    PokemonCatalogView()
}
