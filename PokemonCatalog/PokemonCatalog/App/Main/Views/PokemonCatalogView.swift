//
//  ContentView.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/3/24.
//

import SwiftUI

struct PokemonCatalogView: View {
    
    @StateObject private var viewModel: PokemonViewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            
            SearchBar(text: $viewModel.searchText, placeholderText: "search Pokemon")
            if let pokemons = viewModel.pokemonList?.results {
                List(pokemons, id: \.self) { pokemon in
                    PokeCell(pokemonName: pokemon.name)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 21)
                            .strokeBorder(.greenyellow)
                            .background(
                                RoundedRectangle(cornerRadius: 21).fill(.lavender))
                            .padding(
                                EdgeInsets(
                                    top: 8,
                                    leading: 5,
                                    bottom: 8,
                                    trailing: 5
                                )
                            )
                    )
                }
            } else {
                Text(Constants.Strings.noPokemon)
            }
        }.task {
            await viewModel.loadPokemons()
        }
    }
}

#Preview {
    PokemonCatalogView()
}
