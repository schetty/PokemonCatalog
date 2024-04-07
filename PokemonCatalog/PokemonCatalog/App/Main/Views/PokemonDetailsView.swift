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
                              size: 44))
                .fontWeight(.bold)
                .foregroundStyle(.orange)
        }.marqueeDuration(6.0)
            .frame(height: Constants.Size.screenHeight * 0.18)
            .background(.white)
        if let pokemon = viewModel.pokemon,
           let sprites = pokemon.sprites,
           let other = sprites.other,
           let home = other.home,
           let frontDefault = home.frontDefault {
            AsyncImage(url: URL(string: frontDefault)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            List(pokemonStatistics.sorted(by: <), id: \.key) { key, value in
                PokeDeetsCell(type: .String)
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


