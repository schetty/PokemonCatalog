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
    }
    
    struct Images {
        static let pokemonIcon32 = "icons8-pokemon-32"
    }
}
