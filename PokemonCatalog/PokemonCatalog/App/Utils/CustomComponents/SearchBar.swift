//
//  SearchBar.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/4/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholderText: String
    
    var body: some View {
        HStack {
            Image(Constants.Images.search)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.leading, 10)
            TextField(Constants.Strings.searchPokemon, text: $text)
                .textCase(.lowercase)
                .font(Font.system(size: 18))
                .padding(.horizontal, 10)
                .foregroundColor(.reallyred)
                .padding()
        }.padding(.horizontal, 10)
        .frame(width: Constants.Size.screenWidth * 0.9,
               height: Constants.Size.screenWidth * 0.15)
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(style: StrokeStyle(lineWidth: 4,
                                           dash: [6]))
                .foregroundColor(.persiangreen)
        }
    }
}
