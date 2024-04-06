//
//  ContentView.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/3/24.
//

import SwiftUI

struct PokemonCatalogView: View {
    
    @State private var networkMonitor = NetworkMonitor()
    @StateObject private var viewModel: PokemonViewModel = PokemonViewModel()
    @State private var selectedPokemon: Result?
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            if networkMonitor.isConnected {
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
                                handleLoadMoreIfNeeded(index: i, pokemons: pokemons)
                            }
                        }
                        .navigationDestination(item: $selectedPokemon) { pokemon in
                            PokemonDetailsView(pokemon: pokemon)
                        }
                    } else {
                        Text(Constants.Strings.noPokemon)
                    }
                }
            } else {
                disconnectedView
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
    
    private var disconnectedView: some View {
        ContentUnavailableView(
            "No Network Connection ☹️",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
    
    private func handleLoadMoreIfNeeded(index: Int, pokemons: [Result]) {
         if !isLoading && index == pokemons.count - 1 && viewModel.loadedPokemons.count == viewModel.pokemonList?.count {
             if let list = viewModel.pokemonList {
                 if list.count != pokemons.count {
                     DispatchQueue.main.async {
                         loadMore()
                     }
                 }
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
