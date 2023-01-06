//
//  ListOfPokemon.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

// MARK: - ListOfPokemon
struct ListOfPokemonDomainModel: BaseDomainModel {
    let count: Int
    let next: String
    let previous: String?
    let listOfPokemon: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(id: 1, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}
