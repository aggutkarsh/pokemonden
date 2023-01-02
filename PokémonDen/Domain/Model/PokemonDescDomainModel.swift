//
//  PokemonDesc.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

// MARK: - PokemonDesc
struct PokemonDescDomainModel: BaseDomainModel, Identifiable {
    let eggGroup: [EggGroups]
    let evolutionChain: EvolutionChains
    let flavorTextEntries: [FlavorText]
    let id: Int
}

// MARK: - EggGroup
struct EggGroups: Codable {
    let name: String
    let url: String
}

// MARK: - EvolutionChains
struct EvolutionChains: Codable {
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorText: Codable {
    let flavorText: String
}
