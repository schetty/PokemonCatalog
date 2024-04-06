//
//  PokeCell.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import SwiftUI

enum PokeDeetsType: String {
    case String
    case Bool
    case Int
    case Array
    case Cries
    case Species
    case Sprites
}

struct PokeDeetsCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    let type: PokeDeetsType

    
    var body: some View {
        HStack {
            Text("key")
                .font(Font.headline)
                .foregroundColor(.asparagus)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .truncationMode(.tail)
            Text("value")
                .font(Font.headline)
                .foregroundColor(.asparagus)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
        }.frame(alignment: .leading)
            .padding(8)
            .contentShape(Rectangle())
    }
}
