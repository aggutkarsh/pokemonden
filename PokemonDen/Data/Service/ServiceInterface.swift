//
//  ServiceInterface.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation

protocol ServiceInterface {
    func getListOfPokemon(_ completion:@escaping (ListOfPokemonDataModel) -> Void, failure:@escaping(Error) -> Void)
    func getPokemonDetails(id: Int, _ completion:@escaping (PokemonDetailDataModel) -> Void, failure:@escaping(Error) -> Void)
    func getPokemonDesc(id: Int, _ completion:@escaping (PokemonDescDataModel) -> Void, failure:@escaping(Error) -> Void)
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Data) -> Void, failure:@escaping(Error) -> Void)
}
