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
    @State private var isLoading: Bool = true
    @State private var isFinished = false
    
    var body: some View {
        NavigationStack {
            if isLoading {
                PokeLoader()
            } else {
                SearchBar(text: $viewModel.searchText,
                          placeholderText: Constants.Strings.searchPokemon)
                if let pokemons = viewModel.filteredPokemons {
                    ScrollViewReader { scrollView in
                        List {
                            ForEach(pokemons, id: \.self) { pokemon in
                                PokeCell(pokemonName: pokemon.name,
                                         onShowDetails: {
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
                                .id(pokemon)
                                .onAppear {
                                    if pokemon == pokemons.last {
                                        if let list = viewModel.pokemonList {
                                            if list.count != pokemons.count {
                                               loadMore()
                                           }
                                        }
                                    }
                                }
                            }
                        }
                        .navigationDestination(item: $selectedPokemon) { pokemon in
                            PokemonDetailsView(pokemon: pokemon)
                        }
                    }
                } else {
                    Text(Constants.Strings.noPokemon)
                }
            }
        }.background(.lavender).ignoresSafeArea()
            .task {
                await viewModel.loadPokemons()
                isLoading = false
            }
    }
    
    private func loadMore() {
        Task {
            isLoading = true
            if let next = viewModel.pokemonList?.next {
                await viewModel.loadMorePokemons(next: next)
                isLoading = false
            }
        }
    }
}

#Preview {
    PokemonCatalogView()
}
