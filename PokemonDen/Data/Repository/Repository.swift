//
//  Repository.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class PokemonRepository: RepositoryInferface {
    let service: ServiceInterface
    
    init(service: ServiceInterface) {
        self.service = service
    }
    
    func getListOfPokemon(mapper: BaseMappper, _ completion: @escaping (Swift.Result<ListOfPokemonDomainModel?, Error>) -> Void) {
        service.getListOfPokemon { result in
            switch result {
                case .success(let model):
                    completion(.success(mapper.fromDataToDomainModel(dataModel: model) as? ListOfPokemonDomainModel))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonDetails(id: Int, mapper: BaseMappper, _ completion: @escaping (Swift.Result<PokemonDetailDomainModel?, Error>) -> Void) {
        service.getPokemonDetails(id: id) { result in
            switch result {
                case .success(let model):
                    completion(.success(mapper.fromDataToDomainModel(dataModel: model) as? PokemonDetailDomainModel))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonDesc(id: Int, mapper: BaseMappper, _ completion: @escaping (Swift.Result<PokemonDescDomainModel?, Error>) -> Void) {
        service.getPokemonDesc(id: id) { result in
            switch result {
                case .success(let model):
                    completion(.success(mapper.fromDataToDomainModel(dataModel: model) as? PokemonDescDomainModel))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Swift.Result<Data, Error>) -> Void) {
        service.getPokemonImageData(pokemonId) { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
