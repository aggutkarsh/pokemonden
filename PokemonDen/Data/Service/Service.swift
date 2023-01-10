//
//  Service.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class PokemonService: ServiceInterface {
    let networkClient: NetworkClientInterface
    
    init(client: NetworkClientInterface) {
        self.networkClient = client
    }
    
    func getListOfPokemon(_ completion:@escaping (Swift.Result<ListOfPokemonDataModel, Error>) -> Void) {
        networkClient.fetchData(url: "pokemon", model: ListOfPokemonDataModel.self) {
            result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonDetails(id: Int, _ completion:@escaping (Swift.Result<PokemonDetailDataModel, Error>) -> Void) {
        networkClient.fetchData(url: "pokemon/\(id)/", model: PokemonDetailDataModel.self) { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonDesc(id: Int, _ completion:@escaping (Swift.Result<PokemonDescDataModel, Error>) -> Void) {
        networkClient.fetchData(url: "pokemon-species/\(id)", model: PokemonDescDataModel.self) { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Swift.Result<Data, Error>) -> Void) {
        let url = String(format:"sprites/master/sprites/pokemon/other/dream-world/%d.svg", pokemonId)
        networkClient.fetchImageData(url: url, completion: { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
