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
                .font(Font.subheadline)
                .padding(.horizontal, 10)
                .foregroundStyle(.crayolaorange)
        }
        .frame(width: Constants.Size.screenWidth * 0.9,
               height: 50)
        .background(.lavender).opacity(0.8)
        .cornerRadius(50)
        .shadow(color: Color(.black).opacity(0.3),
                radius: 1, x: 0, y: 4)
    }
}