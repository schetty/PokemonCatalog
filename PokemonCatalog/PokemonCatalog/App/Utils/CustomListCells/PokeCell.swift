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
    
    var body: some View {
        HStack {
            Image("icons8-pokemon-32")
                .foregroundStyle(.crayolaorange)
            
            Text(pokemonName)
                .font(Font.headline)
                .foregroundColor(.asparagus)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
        }.frame(alignment: .leading)
            .padding(8)
            .contentShape(Rectangle())
            .onTapGesture {
            }
    }
}
