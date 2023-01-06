//
//  PokemonDetailMapper.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class PokemonDetailMapper: BaseMappper{
    func fromDataToDomainModel(dataModel: BaseDataModel) -> BaseDomainModel? {
        var domainObj: BaseDomainModel?
        let model = dataModel as? PokemonDetailDataModel
        
        if let modelObj = model {
            domainObj = PokemonDetailDomainModel(abilities: modelObj.abilities, height: modelObj.height, id: modelObj.id, name: modelObj.name, order: modelObj.order, stats: modelObj.stats, types: modelObj.types, weight: modelObj.weight)
        }
        return domainObj
    }
}
