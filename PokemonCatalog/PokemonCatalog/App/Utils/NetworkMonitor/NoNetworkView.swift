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
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}

#Preview {
    NetworkUnavailableView()
}
