//
//  PokeCell.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import SwiftUI

struct PokeCell: View {
    @Environment(\.colorScheme) var colorScheme
    let pokemonName: String
    var onShowDetails: () -> Void
    
    var body: some View {
        HStack {
            Image(Constants.Images.pokemonIcon32)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(pokemonName)
                .font(Font.headline)
                .foregroundColor(.asparagus)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .accessibilityLabel(pokemonName)
                .accessibilityHint("Select pokemon to learn more details about \(pokemonName).")
        }.frame(alignment: .leading)
            .padding(8)
            .contentShape(Rectangle())
            .onTapGesture {
                onShowDetails()
            }
    }
}
