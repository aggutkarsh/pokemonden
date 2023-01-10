//
//  DetailUseCase.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class DetailUseCase {
    let repository: RepositoryInferface
    
    init(repo:RepositoryInferface) {
        self.repository = repo
    }
    
    func getPokemonDesc(id:Int, _ completion: @escaping (Swift.Result<PokemonDescDomainModel?, Error>) -> Void) {
        repository.getPokemonDesc(id: id, mapper: PokemonDescMapper()) { result in
            switch result {
                case .success(let pokemonDesc):
                    completion(.success(pokemonDesc))
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
