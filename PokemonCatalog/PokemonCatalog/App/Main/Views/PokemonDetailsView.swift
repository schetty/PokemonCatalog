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
            }
        }
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
            List(viewModel.displayables.sorted(by: { $0.key < $1.key }), id: \.key) { i in
                let key = i.key
                let value = i.value
                PokeDeetsCell(type: determineStatType(forKey: key,
                                                      value: value),
                              key: key,
                              value: value)
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
    
    //TODO : find a way to put this logic in the view model instead
    private func determineStatType(forKey key: String, value: Any) -> StatValueType {
        switch key {
        case "abilities":
            if let abilities = value as? [Ability] {
                return .Abilities(abilities)
            }
        case "species":
            if let species = value as? [Species] {
                return .SpeciesArr(species)
            }
            if let species = value as? Species {
                return .Species(species)
            }
        case "moves":
            if let moves = value as? [Move] {
                return .Moves(moves)
            }
        case "cry":
            if let cries = value as? Cries {
                return .Cries(cries)
            }
        default:
            if let str = value as? String {
                return .String(str)
            } else if let int = value as? Int {
                return .Int(int)
            }
        }
        return .String("Unknown")
    }

}


