//
//  MockRepository.swift
//  PokémonDenTests
//
//  Created by Utkarsh Agrawal on 28/12/22.
//

import XCTest
@testable import PokemonDen

struct MockRepository: RepositoryInferface {
    let service: ServiceInterface
    
    func getPokemonDetails(id: Int, mapper: BaseMappper, _ completion: @escaping (Swift.Result<PokemonDetailDomainModel?, Error>) -> Void) {
        let response:PokemonDetailDomainModel =  Bundle.main.decode(file: "pokemonDetails.json")
        completion(.success(response))
    }
    
    func getPokemonDesc(id: Int, mapper: BaseMappper, _ completion: @escaping (Swift.Result<PokemonDescDomainModel?, Error>) -> Void) {
        let response:PokemonDescDomainModel =  Bundle.main.decode(file: "pokemonSpecies.json")
        completion(.success(response))
    }
    
    func getPokemonImageData(_ pokemonId: Int, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let response:Data =  Data()
        completion(.success(response))
    }
    
    func getListOfPokemon(mapper: BaseMappper, _ completion: @escaping (Swift.Result<ListOfPokemonDomainModel?, Error>) -> Void) {
        let response:ListOfPokemonDomainModel =  Bundle.main.decode(file: "pokemonList.json")
        completion(.success(response))
    }
}
