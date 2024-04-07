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
                    ZStack {
                        LinearGradient(colors: [.white, .icterineyellow, .reallyred],
                                       startPoint: .top,
                                       endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                        VStack {
                            pokemonCatalogView
                        }
                    }
                }
            } else {
                disconnectedView
            }
        }.task {
                await viewModel.loadPokemons()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLoading = false
                }
            }
    }
    
    @ViewBuilder
    private var pokemonCatalogView: some View {
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
                        .strokeBorder(.reallyred)
                        .background(
                            RoundedRectangle(cornerRadius: 21).fill(.icterineyellow))
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
    
    private var disconnectedView: some View {
        ContentUnavailableView(
            "No Network Connection ☹️",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
    
    private func handleLoadMoreIfNeeded(index: Int, pokemons: [Result]) {
        if let list = viewModel.pokemonList {
            if !isLoading && index == pokemons.count - 1 && viewModel.loadedPokemons.count == pokemons.count {
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
