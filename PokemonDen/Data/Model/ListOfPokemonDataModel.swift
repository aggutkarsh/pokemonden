//
//  ListOfPokemon.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

// MARK: - ListOfPokemon
struct ListOfPokemonDataModel: BaseDataModel {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
}

struct Result: Codable, Equatable {
    let name: String
    let url: String
}
