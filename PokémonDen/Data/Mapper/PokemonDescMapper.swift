//
//  PokemonDescMapper.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

class PokemonDescMapper: BaseMappper{
    func fromDataToDomainModel(dataModel: BaseDataModel) -> BaseDomainModel? {
        var domainObj: BaseDomainModel?
        let model = dataModel as? PokemonDescDataModel
        
        if let modelObj = model {
            domainObj = PokemonDescDomainModel(eggGroup: getEggGroup(result: modelObj.egg_groups), evolutionChain: EvolutionChains(url: modelObj.evolution_chain.url), flavorTextEntries: getFlavorText(result: modelObj.flavor_text_entries), id: modelObj.id)
        }
        
        return domainObj
    }
  
    func getEggGroup(result: [EggGroup]) -> [EggGroups] {
        var list = [EggGroups]()
        
        result.forEach { eggGroup in
            list.append(EggGroups(name: eggGroup.name, url: eggGroup.url))
        }
        
        return list
    }
    
    func getFlavorText(result: [FlavorTextEntry]) -> [FlavorText] {
        var list = [FlavorText]()
        
        result.forEach { text in
            list.append(FlavorText(flavorText: text.flavor_text))
        }
        
        return list
    }
}


