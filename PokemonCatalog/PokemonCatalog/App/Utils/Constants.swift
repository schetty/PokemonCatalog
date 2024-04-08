//
//  Constants.swift
//  PokemonCatalog
//
//  Created by User on 4/3/24.
//

import SwiftUI

struct Constants {
    struct Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }
    
    struct URLs {
        static let pokemonAPIURL = "https://pokeapi.co/api/v2/pokemon/"
    }
    
    struct Strings {
        static let noPokemon = "No pokemons 😞"
        static let searchPokemon = "Search Pokemon"
        static let noNetwork = "No Internet Connection"
        static let pleaseTryAgain = "Please check your connection and try again."
    }
    
    struct Images {
        static let pokemonIcon32 = "icons8-pokemon-32"
        static let pokeBall = "icons8-pokemon-100"
        static let search = "icons8-search"
    }
    
    struct Fonts {
        static let gameFont = "04B_30__"
        static let minecraft = "Minecraft"
    }
}
