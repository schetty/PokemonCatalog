//
//  NoNetworkView.swift
//  PokemonCatalog
//
//  Created by User on 4/6/24.
//

import Foundation
import SwiftUI

struct NetworkUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            Constants.Strings.noNetwork,
            systemImage: "wifi.exclamationmark",
            description: Text(Constants.Strings.pleaseTryAgain)
        )
    }
}

#Preview {
    NetworkUnavailableView()
}
