//
//  Repository.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class Repository: RepositoryInferface {
    let service: ServiceInterface
    var mapper: BaseMappper
    
    init(service: ServiceInterface, mapper: BaseMappper) {
        self.service = service
        self.mapper = mapper
    }
    
    func getListOfPokemon(_ completion: @escaping (ListOfPokemonDomainModel?) -> Void, failure:@escaping(Error) -> Void) {
        service.getListOfPokemon { model in
            completion(self.mapper.fromDataToDomainModel(dataModel: model) as? ListOfPokemonDomainModel)
        } failure: { error in
            failure(error)
        }
    }
    
    func getPokemonDetails(id: Int, _ completion: @escaping (PokemonDetailDomainModel?) -> Void ,failure:@escaping(Error) -> Void) {
        service.getPokemonDetails(id: id) { model in
            completion(self.mapper.fromDataToDomainModel(dataModel: model) as? PokemonDetailDomainModel)
        } failure: { error in
            failure(error)
        }
    }
    
    func getPokemonDesc(id: Int, _ completion: @escaping (PokemonDescDomainModel?) -> Void ,failure:@escaping(Error) -> Void) {
        service.getPokemonDesc(id: id) { model in
            completion(self.mapper.fromDataToDomainModel(dataModel: model) as? PokemonDescDomainModel)
        } failure: { error in
            failure(error)
        }
    }
    
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Data) -> Void,failure:@escaping(Error) -> Void) {
        service.getPokemonImageData(pokemonId) { data in
            completion(data)
        } failure: { error in
            failure(error)
        }
    }
}
