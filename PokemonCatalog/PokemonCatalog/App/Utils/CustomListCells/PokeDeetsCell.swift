//
//  PokeCell.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import SwiftUI

enum StatValueType {
    case Abilities([Ability])
    case String(String)
    case Cries(Cries)
    case SpeciesArr([Species])
    case Moves([Move])
    case Species(Species)
    case Int(Int)
}

struct PokeDeetsCell: View {
    @Environment(\.colorScheme) var colorScheme
    let type: StatValueType
    let key: String
    let value: Any
        
    var body: some View {
        HStack {
            switch type {
            case .Abilities(let array):
                Text(key + ": " + array.map { $0.ability?.name ?? "Unknown" }.joined(separator: ", "))
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            case .String(let string):
                Text(key + ": "  + string)
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            case .Cries(let cries):
                Text(key + ": " + "\(cries.latest ?? "Unknown"), \(cries.legacy ?? "Unknown")")
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            case .SpeciesArr(let array):
                Text(key + ": " + array.map { $0.name ?? "Unknown" }.joined(separator: ", "))
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            case .Moves(let array):
                Text(key + ": " + array.map { $0.move?.name ?? "Unknown" }.joined(separator: ", "))
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            case .Int(let int):
                Text(key + ": " + "\(int)")
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            case .Species(let species):
                Text(key + ": " + "\(species.name ?? "Unknown")")
                    .font(Font.headline)
                    .foregroundColor(.asparagus)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .truncationMode(.tail)
            }
        }.frame(alignment: .leading)
            .padding(8)
            .contentShape(Rectangle())
    }
}
