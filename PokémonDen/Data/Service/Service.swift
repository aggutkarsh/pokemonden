//
//  Service.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class Services: ServiceInterface {
    let networkClient: NetworkClientInterface
    
    init(client: NetworkClientInterface) {
        self.networkClient = client
    }
    
    func getListOfPokemon(_ completion:@escaping (ListOfPokemonDataModel) -> Void, failure:@escaping(Error) -> Void) {
        networkClient.fetchPokemonList(model: ListOfPokemonDataModel.self) { data in
            completion(data)
            print(data)
        } failure: { error in
            failure(error)
            print(error)
        }
    }
    
    func getPokemonDetails(id: Int, _ completion:@escaping (PokemonDetailDataModel) -> Void, failure:@escaping(Error) -> Void) {
        networkClient.fetchPokemonDetails(id: id, model: PokemonDetailDataModel.self) { data in
               completion(data)
               print(data)
               
           } failure: { error in
               failure(error)
               print(error)
           }
       }
    
    func getPokemonDesc(id: Int, _ completion:@escaping (PokemonDescDataModel) -> Void, failure:@escaping(Error) -> Void) {
        networkClient.fetchPokemonDesc(id: id, model: PokemonDescDataModel.self) { data in
               completion(data)
               print(data)
               
           } failure: { error in
               failure(error)
               print(error)
           }
       }
    
    func getPokemonImageData(_ pokemonId: Int, completion:@escaping (Data) -> Void, failure:@escaping(Error) -> Void) {
        networkClient.fetchPokemonImage(id: pokemonId, completion: { data in
            completion(data)
        }, failure: { error in
            failure(error)
            print(error)
        })
    }
}
