//
//  RepositoryInterface.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation

protocol RepositoryInferface {
    var service: ServiceInterface {get}
    
    func getListOfPokemon(mapper: BaseMappper, _ completion:@escaping (Swift.Result<ListOfPokemonDomainModel?, Error>) -> Void)
    func getPokemonDetails(id: Int, mapper: BaseMappper, _ completion:@escaping (Swift.Result<PokemonDetailDomainModel?, Error>) -> Void)
    func getPokemonDesc(id: Int, mapper: BaseMappper, _ completion:@escaping (Swift.Result<PokemonDescDomainModel?, Error>) -> Void)
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Swift.Result<Data, Error>) -> Void)
}
