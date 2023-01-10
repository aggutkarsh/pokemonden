//
//  ServiceInterface.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation

protocol ServiceInterface {
    func getListOfPokemon(_ completion:@escaping (Swift.Result<ListOfPokemonDataModel, Error>) -> Void)
    func getPokemonDetails(id: Int, _ completion:@escaping (Swift.Result<PokemonDetailDataModel, Error>) -> Void)
    func getPokemonDesc(id: Int, _ completion:@escaping (Swift.Result<PokemonDescDataModel, Error>) -> Void)
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Swift.Result<Data, Error>) -> Void)
}
