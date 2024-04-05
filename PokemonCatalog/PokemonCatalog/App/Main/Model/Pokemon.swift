//
//  PokemonDTO.swift
//  PokemonCatalog
//
//  Created by Naomi on 4/3/24.
//

import Foundation
import SwiftData

// MARK: - Pokemon Statistics
final class Pokemon: Identifiable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let cries: Cries?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abilities = try container.decode([Ability].self, forKey: .abilities)
        baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        cries = try container.decode(Cries.self, forKey: .cries)
        forms = try container.decode([Species].self, forKey: .forms)
        gameIndices = try container.decode([GameIndex].self, forKey: .gameIndices)
        height = try container.decode(Int.self, forKey: .height)
        id = try container.decode(Int.self, forKey: .id)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
        locationAreaEncounters = try container.decode(String.self, forKey: .locationAreaEncounters)
        moves = try container.decode([Move].self, forKey: .moves)
        name = try container.decode(String.self, forKey: .name)
        order = try container.decode(Int.self, forKey: .order)
        species = try container.decode(Species.self, forKey: .species)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        stats = try container.decode([Stat].self, forKey: .stats)
        types = try container.decode([TypeElement].self, forKey: .types)
        weight = try container.decode(Int.self, forKey: .weight)
    }
}

// separate all Codable coupling from the data object model

extension Pokemon: Decodable {
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case cries, forms
        case gameIndices = "game_indices"
        case height
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case species, sprites, stats, types, weight
    }
}

// MARK: - Ability
struct Ability {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?
}

extension Ability: Decodable {
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species {
    let name: String?
    let url: String?
}

extension Species: Decodable {}

// MARK: - Cries
struct Cries {
    let latest, legacy: String?
}

extension Cries: Decodable {}

// MARK: - GameIndex
struct GameIndex {
    let gameIndex: Int?
    let version: Species?
    
    init(gameIndex: Int, version: Species) {
        self.gameIndex = gameIndex
        self.version = version
    }
}

extension GameIndex: Decodable {
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Move
struct Move {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?
}

extension Move: Decodable {
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?
}

extension VersionGroupDetail: Decodable  {
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - GenerationV
struct GenerationV {
    let blackWhite: Sprites?
}

extension GenerationV: Decodable {
    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - GenerationIv
struct GenerationIv {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites?
}

extension GenerationIv: Decodable {
    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - Versions
struct Versions {
    let generationI: GenerationI?
    let generationIi: GenerationIi?
    let generationIii: GenerationIii?
    let generationIv: GenerationIv?
    let generationV: GenerationV?
    let generationVi: [String: Home]?
    let generationVii: GenerationVii?
    let generationViii: GenerationViii?
}

extension Versions: Decodable {
    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

// MARK: - Other
struct Other {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?
    let showdown: Sprites?
}

extension Other: Decodable {
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
        case showdown
    }
}


// MARK: - Sprites
final class Sprites {
    let backDefault, backFemale, backShiny: String?
    let backShinyFemale: String?
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?

    init(backDefault: String, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

extension Sprites: Decodable {
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }
}


// MARK: - GenerationI
struct GenerationI {
    let redBlue, yellow: RedBlue
}
extension  GenerationI: Decodable {
    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - RedBlue
struct RedBlue {
    let backDefault, backGray, backTransparent, frontDefault: String?
    let frontGray, frontTransparent: String?
}

extension RedBlue: Decodable {
    enum CodingKeys: String, CodingKey {
     case backDefault = "back_default"
     case backGray = "back_gray"
     case backTransparent = "back_transparent"
     case frontDefault = "front_default"
     case frontGray = "front_gray"
     case frontTransparent = "front_transparent"
 }
}

// MARK: - GenerationIi
struct GenerationIi {
    let crystal: Crystal?
    let gold, silver: Gold?
}

extension GenerationIi: Decodable {}

// MARK: - Crystal
struct Crystal {
    let backDefault, backShiny, backShinyTransparent, backTransparent: String?
    let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String?
}

extension Crystal: Decodable {
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backShinyTransparent = "back_shiny_transparent"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyTransparent = "front_shiny_transparent"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - Gold
struct Gold {
    let backDefault, backShiny, frontDefault, frontShiny: String?
    let frontTransparent: String?
}

extension Gold: Decodable {
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIii
struct GenerationIii {
    let emerald: OfficialArtwork?
    let fireredLeafgreen, rubySapphire: Gold?
}

extension GenerationIii: Decodable {
    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork {
    let frontDefault, frontShiny: String?
}

extension OfficialArtwork: Decodable {
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Home
struct Home {
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
}

extension Home: Decodable {
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - GenerationVii
struct GenerationVii {
    let icons: DreamWorld
    let ultraSunUltraMoon: Home
}

extension GenerationVii: Decodable {
    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - DreamWorld
struct DreamWorld {
    let frontDefault: String?
    let frontFemale: String?
}

extension DreamWorld: Decodable {
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - GenerationViii
struct GenerationViii {
    let icons: DreamWorld?
}
extension GenerationViii: Decodable {}

// MARK: - Stat
struct Stat {
    let baseStat, effort: Int?
    let stat: Species?
}

extension Stat: Decodable {
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement {
    let slot: Int?
    let type: Species?
}

extension TypeElement: Decodable {}
