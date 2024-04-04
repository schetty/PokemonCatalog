//
//  ContentView.swift
//  PokemonCatalog
//
//  Created by User on 4/3/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: PokemonViewModel = PokemonViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button(action: {
                Task {
                    await viewModel.loadPokemons()
                }
            }, label: {
                Text("get pokemons")
            })
        }
        .padding()
    }
}

#Preview {
    MainView()
}
