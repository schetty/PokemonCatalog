//
//  CustomLoader.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/5/24.
//

import SwiftUI

struct PokeLoader: View {
    @State private var animationAmount: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Image(Constants.Images.pokeBall)
                .resizable()
                .scaledToFit()
                .frame(width: 100 * animationAmount,
                       height: 100 * animationAmount)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        animationAmount = 1.2
                    }
                }
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
