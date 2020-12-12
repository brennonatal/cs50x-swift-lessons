import Foundation

struct PokemonListResults: Codable {
    let results: [PokemonListResult]
}

struct PokemonListResult: Codable {
    let name: String
    let url: String
}

struct PokemonResult: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprite
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct PokemonSprite: Codable {
    let front_default: String
}

struct PokemonSpecies: Codable {
    let flavor_text_entries: [FlavorTextEntry]
}

struct FlavorTextEntry: Codable {
    let flavor_text: String
    let language: Language
}

struct Language: Codable {
    let name: String
}
