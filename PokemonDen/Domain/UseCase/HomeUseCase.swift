//
//  HomeUsecase.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class HomeUseCase {
    let repository: RepositoryInferface
    
    init(repo:RepositoryInferface) {
        self.repository = repo
    }
    
    func getDetails(id:Int, _ completion: @escaping (Swift.Result<PokemonDetailDomainModel?, Error>) -> Void) {
        repository.getPokemonDetails(id: id, mapper: PokemonDetailMapper()) { result in
            switch result {
                case .success(let pokemonDetail):
                    completion(.success(pokemonDetail))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getListOfPokemon(_ completion: @escaping (Swift.Result<ListOfPokemonDomainModel?, Error>) -> Void) {
        repository.getListOfPokemon(mapper: ListOfPokemonMapper()) { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonImageData(pokemonId: Int, completion: @escaping (Swift.Result<Data, Error>) -> Void ) {
        repository.getPokemonImageData(pokemonId) { result in
            switch result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

}
