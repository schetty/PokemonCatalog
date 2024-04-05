//
//  PokeCell.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import SwiftUI

struct PokeDeetsCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    let statKey: String
    let statValue: String
    
    var body: some View {
        HStack {
            Text(statKey + ": ")
                .font(Font.headline)
                .foregroundColor(.asparagus)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .truncationMode(.tail)
            Text(statValue)
                .font(Font.headline)
                .foregroundColor(.asparagus)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
        }.frame(alignment: .leading)
            .padding(8)
            .contentShape(Rectangle())
    }
    
}
