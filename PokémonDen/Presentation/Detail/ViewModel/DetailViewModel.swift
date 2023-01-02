//
//  DetailViewModel.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
    let useCase: DetailUseCase?
    
    @Published var pokemonDesc: PokemonDescDomainModel?
    
    init(useCase: DetailUseCase) {
        self.useCase = useCase
    }
    
    func getPokemonDesc(pokemonIndex: Int) {
        useCase?.getPokemonDesc(id: pokemonIndex, { [weak self] desc in
            DispatchQueue.main.async {
                self?.pokemonDesc = desc
            }
        })
    }
    
    func getPokemonEggGroup() -> String {
        var eggGroup:String = ""
        
        pokemonDesc?.eggGroup.forEach { group in
            if eggGroup == "" {
                eggGroup = "\(group.name.localizedCapitalized)"
            } else {
                eggGroup = "\(eggGroup), \(group.name.localizedCapitalized)"
            }
        }
        
        return eggGroup
    }
    
    func getPokemonAbilities(pokemonDetail: PokemonDetailDomainModel) -> String{
        var abilities:String = ""
        
        pokemonDetail.abilities.forEach({ ability in
            if abilities == "" {
                abilities = "\(ability.ability.name.localizedCapitalized)"
            } else {
                abilities = "\(abilities), \(ability.ability.name.localizedCapitalized)"
            }
        })
        return abilities
    }
    
    func getPokemonTypes(pokemonDetail: PokemonDetailDomainModel) -> [String] {
        var listOfType = [String]()
        
        pokemonDetail.types.forEach({ type in
            listOfType.append(type.type.name)
        })
        
        return listOfType
    }
    
    func getListOfGradientColor(pokemonDetail: PokemonDetailDomainModel) -> [Color] {
        var listOfColor = [Color]()
        let tasks:[String] = getPokemonTypes(pokemonDetail: pokemonDetail)
        
        tasks.forEach { task in
            listOfColor.append(Color(task.localizedCapitalized))
        }
        
        return listOfColor
    }
    
    func getStatValue(_ statName: String, pokemonDetail: PokemonDetailDomainModel) -> Int {
        var value = 0
        
        pokemonDetail.stats.forEach({ stat in
            if stat.stat.name == statName {
                value = stat.base_stat
            }
        })
        
        return value
    }
    
    func getPokemonImageData(pokemonId: Int , completion: @escaping (UIImage?) -> Void ) {
        useCase?.getPokemonImageData(pokemonId: pokemonId, completion: { imageData in
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        })
    }
    
    func getPokemonDetails(pokemonIndex: Int, completion: @escaping (PokemonDetailDomainModel?) -> Void) {
        useCase?.getDetails(id: pokemonIndex, { details in
            completion(details)
        })
    }
    
    func getPokemonIndex(pokemon:Pokemon, listOfPokemonDetail: [PokemonDetailDomainModel]) -> Int {
        let id = listOfPokemonDetail.firstIndex { detail in
            detail.id == pokemon.id
        }
        return id ?? 0
    }
}
