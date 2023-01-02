//
//  PokemonDesc.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

// MARK: - PokemonDesc
struct PokemonDescDataModel: BaseDataModel, Identifiable {
    let egg_groups: [EggGroup]
    let evolution_chain: EvolutionChain
    let flavor_text_entries: [FlavorTextEntry]
    let id: Int
}

// MARK: - EggGroup
struct EggGroup: Codable {
    let name: String
    let url: String
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavor_text: String
}


