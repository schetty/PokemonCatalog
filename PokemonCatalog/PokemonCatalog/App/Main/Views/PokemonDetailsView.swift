//
//  PokemonDetailsView.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/5/24.
//

import SwiftUI
import Marquee

struct PokemonDetailsView: View {
    
    @StateObject private var viewModel: PokemonDetailsViewModel = PokemonDetailsViewModel()
    let pokemon: Result
    
    @State private var pokemonStatistics: [String: String] = [:]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .greenyellow, .asparagus, .crayolaorange],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            VStack {
                pokemonDetailsView
                Spacer()
            }.task {
                await viewModel.loadPokemonDetails(url: pokemon.url)
                extractStatistics()
            }
        }
    }
    
    private func extractStatistics() {
        guard let pokemon = viewModel.pokemon else { return }
        var dictionary: [String: String] = [:]
        
        if let name = pokemon.name {
            dictionary["name"] = name
        }
        if let baseExperience = pokemon.baseExperience {
            dictionary["base_experience"] = "\(baseExperience)"
        }
        if let height = pokemon.height {
            dictionary["height"] = "\(height)"
        }
        if let weight = pokemon.weight {
            dictionary["weight"] = "\(weight)"
        }
        if let order = pokemon.order {
            dictionary["order"] = "\(order)"
        }
        if let isDefault = pokemon.isDefault {
            dictionary["isDefault"] = "\(isDefault)"
        }
        if let species = pokemon.species,
           let speciesName = species.name {
            dictionary["species"] = "\(speciesName)"
        }
        pokemonStatistics = dictionary
    }
    
    
    @ViewBuilder
    private var pokemonDetailsView: some View {
        Marquee {
            Text("Name: \(pokemon.name)")
                .font(.custom(Constants.Fonts.minecraft,
                              size: 30))
                .fontWeight(.bold)
                .foregroundStyle(.orange)
                .background(.white)
                .frame(width: Constants.Size.screenWidth * 1.3)
        }.marqueeDuration(6.0)
            .frame(height: Constants.Size.screenHeight * 0.25)
        if let pokemon = viewModel.pokemon,
           let sprites = pokemon.sprites,
           let versions = sprites.versions,
           let genV = versions.generationV,
           let blackWhite = genV.blackWhite,
           let animated = blackWhite.animated,
           let frontDefault = animated.frontDefault {
            AsyncImage(url: URL(string: frontDefault))
                .frame(alignment: .center)
                .padding(10)
            List(pokemonStatistics.sorted(by: <), id: \.key) { key, value in
                PokeDeetsCell(statKey: key, statValue: value)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 21)
                            .strokeBorder(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 21).fill(.greenyellow))
                            .padding(
                                EdgeInsets(
                                    top: 8,
                                    leading: 14,
                                    bottom: 8,
                                    trailing: 14
                                )
                            )
                    )
                    .id(pokemon)
            }.listStyle(.plain)
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
        }
    }
}


