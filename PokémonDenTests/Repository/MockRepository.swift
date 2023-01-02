//
//  MockRepository.swift
//  PokémonDenTests
//
//  Created by Utkarsh Agrawal on 28/12/22.
//

import XCTest
@testable import PokémonDen

struct MockRepository: RepositoryInferface {
    var service: ServiceInterface
    var mapper: BaseMappper
    
    func getPokemonDetails(id: Int, _ completion: @escaping (PokemonDetailDomainModel?) -> Void, failure: @escaping (Error) -> Void) {
        let response:PokemonDetailDomainModel =  Bundle.main.decode(file: "pokemonDetails.json")
        completion(response)
    }
    
    func getPokemonDesc(id: Int, _ completion: @escaping (PokemonDescDomainModel?) -> Void, failure: @escaping (Error) -> Void) {
        let response:PokemonDescDomainModel =  Bundle.main.decode(file: "pokemonSpecies.json")
        completion(response)
    }
    
    func getPokemonImageData(_ pokemonId: Int, completion: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        let response:Data =  Data()
        completion(response)
    }
    
    func getListOfPokemon(_ completion: @escaping (ListOfPokemonDomainModel?) -> Void, failure:@escaping(Error) -> Void) {
        let response:ListOfPokemonDomainModel =  Bundle.main.decode(file: "pokemonList.json")
        completion(response)
    }
}
