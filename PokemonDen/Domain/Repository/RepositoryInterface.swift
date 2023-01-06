//
//  RepositoryInterface.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation

protocol RepositoryInferface {
    var service: ServiceInterface {get}
    var mapper: BaseMappper {get set}
    
    func getListOfPokemon(_ completion:@escaping (ListOfPokemonDomainModel?) -> Void,failure:@escaping(Error) -> Void)
    func getPokemonDetails(id: Int, _ completion:@escaping (PokemonDetailDomainModel?) -> Void,failure:@escaping(Error) -> Void)
    func getPokemonDesc(id: Int, _ completion:@escaping (PokemonDescDomainModel?) -> Void,failure:@escaping(Error) -> Void)
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Data) -> Void,failure:@escaping(Error) -> Void)
}
