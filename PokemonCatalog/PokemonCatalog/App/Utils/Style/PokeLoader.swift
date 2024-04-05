//
//  CustomLoader.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/5/24.
//

import SwiftUI

struct PokeLoader: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            Image(Constants.Images.pokeBall)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(360))
                .animation(
                    .easeInOut(duration: 2)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            PokeLoader()
        }
    }
}

#Preview {
    ContentView()
}
