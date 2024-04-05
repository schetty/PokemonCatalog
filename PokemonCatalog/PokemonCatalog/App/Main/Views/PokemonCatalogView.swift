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
    
    var body: some View {
        NavigationStack {
            if isLoading {
                PokeLoader()
            } else {
                SearchBar(text: $viewModel.searchText,
                          placeholderText: Constants.Strings.searchPokemon)
                if let pokemons = viewModel.filteredPokemons {
                    List(0..<pokemons.count, id: \.self) { i in
                        PokeCell(pokemonName: pokemons[i].name,
                                 onShowDetails: {
                            selectedPokemon = pokemons[i]
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
                        ).onAppear {
                            if !isLoading && pokemons[i] == pokemons.last && i + 1 == viewModel.loadedPokemons.count {
                                if let list = viewModel.pokemonList {
                                    if list.count != pokemons.count {
                                        DispatchQueue.main.async {
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
                } else {
                    Text(Constants.Strings.noPokemon)
                }
                
            }
        }.background(.lavender)
            .ignoresSafeArea()
            .task {
                await viewModel.loadPokemons()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLoading = false
                }
            }
    }
    
    private func loadMore() {
        Task {
            isLoading = true
            if let next = viewModel.pokemonList?.next {
                await viewModel.loadMorePokemons(next: next)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    PokemonCatalogView()
}
