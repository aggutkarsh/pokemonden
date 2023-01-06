//
//  DetailUseCase.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class DetailUseCase {
    var repository: RepositoryInferface
    
    init(repo:RepositoryInferface) {
        self.repository = repo
    }

    func getDetails(id:Int, _ completion: @escaping (PokemonDetailDomainModel?) -> Void) {
        self.repository.mapper = PokemonDetailMapper()
        
        repository.getPokemonDetails(id: id) { pokemonDetail in
            
            completion(pokemonDetail)
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonDesc(id:Int, _ completion: @escaping (PokemonDescDomainModel?) -> Void) {
        self.repository.mapper = PokemonDescMapper()
        
        repository.getPokemonDesc(id: id) { pokemonDesc in
            completion(pokemonDesc)
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonImageData(pokemonId: Int, completion: @escaping (Data) -> Void ) {
        repository.getPokemonImageData(pokemonId) { imageData in
            completion(imageData)
        } failure: { error in
            print(error)
        }
    }
}
