//
//  ListOfPokemonMapper.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class ListOfPokemonMapper: BaseMappper{
    func fromDataToDomainModel(dataModel: BaseDataModel) -> BaseDomainModel? {
        var domainObj: BaseDomainModel?
        let model = dataModel as? ListOfPokemonDataModel
        
        if let modelObj = model {
            domainObj =  ListOfPokemonDomainModel(count: modelObj.count, next: modelObj.next, previous: modelObj.previous, listOfPokemon: getListOfPokemon(result: modelObj.results))
        }
       
        return domainObj
    }
    
    func getListOfPokemon(result: [Result]) -> [Pokemon] {
        var list = [Pokemon]()
        
        for (index,pokemon) in result.enumerated() {
            list.append(Pokemon(id: index+1, name: pokemon.name, url: pokemon.url))
        }
        
        return list
    }
}
