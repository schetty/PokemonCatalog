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
                .padding(.leading, 10)
            TextField(placeholderText, text: $text)
                .textCase(.lowercase)
                .font(Font.system(size: 16))
                .padding(.horizontal, 10)
                .foregroundStyle(.crayolaorange)
        }
        .frame(width: Constants.Size.screenWidth * 0.9,
               height: 50)
        .background(.white).opacity(0.8)
        .cornerRadius(50)
        .shadow(color: Color(.lavender).opacity(0.8),
                radius: 1, x: 0, y: 4)
    }
}
