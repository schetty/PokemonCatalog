//
//  ContentView.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/3/24.
//

import SwiftUI

struct PokemonCatalogView: View {
    
    @StateObject private var viewModel: PokemonViewModel = PokemonViewModel()
    @State private var selectedPokemon: Result?
    
    var body: some View {
        NavigationStack {
            SearchBar(text: $viewModel.searchText,
                      placeholderText: Constants.Strings.searchPokemon)
            if let pokemons = viewModel.pokemonList?.results {
                List(pokemons, id: \.self) { pokemon in
                    PokeCell(pokemonName: pokemon.name, onShowDetails: {
                        selectedPokemon = pokemon
                    })
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
                }.navigationDestination(item: $selectedPokemon) { pokemon in
                    PokemonDetailsView(pokemon: pokemon)
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
