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
        if let pokemon = viewModel.pokemon,
           let name = pokemon.name,
           let species = pokemon.species,
           let speciesName = species.name,
           let weight = pokemon.weight,
           let height = pokemon.height,
           let sprites = pokemon.sprites,
           let versions = sprites.versions,
           let genV = versions.generationV,
           let blackWhite = genV.blackWhite,
           let animated = blackWhite.animated,
           let frontDefault = animated.frontDefault {
            Marquee {
                Text("Name: \(name)")
                    .font(.custom(Constants.Fonts.minecraft,
                                  size: 30))
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                    .background(.white)
                    .frame(width: Constants.Size.screenWidth * 1.3)
            }.marqueeDuration(6.0)
                .frame(height: Constants.Size.screenHeight * 0.25)
            .background(Color.white)
            AsyncImage(url: URL(string: frontDefault))
                .frame(alignment: .center)
                .padding(10)
            Text("Species: \(speciesName)")
            Text("Weight: \(weight)")
            Text("Height: \(height)")
        } else {
            Text("Loading details...")
        }
    }
}

