//
//  PokemonDetailsModel.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//


import Foundation

struct PokemonDetailDomainModel : BaseDomainModel, Identifiable {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let name: String
    let order: Int
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
}

