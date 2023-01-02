//
//  HomeViewModel.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation
import SwiftUI

struct ListOfPokemonDetailEntity: Codable, Identifiable {
    var id: Int
    var pokemonDetail: PokemonDetailDomainModel
    var listOfType: [String]
}

class HomeViewModel: ObservableObject {
    let useCase: HomeUseCase?
    
    @Published var listOfPokemonModel: ListOfPokemonDomainModel?
    @Published var listOfPokemonDetail = [ListOfPokemonDetailEntity]()
    @Published var searchText = ""
    
    init(useCase: HomeUseCase){
        self.useCase = useCase
    }
    
    var filteredPokemon: [Pokemon] {
        var filteredList = [Pokemon]()
        
        filteredList = self.listOfPokemonModel?.listOfPokemon ?? []

        filteredList = (filteredList.filter {
            $0.name.starts(with: searchText.lowercased()) || $0.id == Int(searchText)
        })


        return filteredList
    }
    
    func getPokemonListModel() {
        useCase?.getListOfPokemon({ [weak self] data in
            DispatchQueue.main.async {
                self?.listOfPokemonModel = data
                data?.listOfPokemon.forEach({ pokemon in
                    self?.getDetails(pokemonIndex: pokemon.id)
                })
            }
        })
    }
    
    func getDetails(pokemonIndex: Int) {
        useCase?.getDetails(id: pokemonIndex, { details in
            DispatchQueue.main.async {
                self.listOfPokemonDetail.append(ListOfPokemonDetailEntity(id: pokemonIndex, pokemonDetail: details!, listOfType: []))
            }
        })
    }
    
    func getPokemonTypes(detail:PokemonDetailDomainModel) -> [String] {
        var listOfType = [String]()
        
        detail.types.forEach({ type in
            listOfType.append(type.type.name)
        })
        
        return listOfType
    }
    
    func getListOfGradientColor(detail: PokemonDetailDomainModel) -> [Color] {
        var listOfColor = [Color]()
        let tasks:[String] = getPokemonTypes(detail: detail)
        
        tasks.forEach { task in
            listOfColor.append(Color(task.localizedCapitalized))
        }
        
        return listOfColor
    }
    
    func getPokemonImageData(pokemonId: Int , completion: @escaping (UIImage?) -> Void ) {
        useCase?.getPokemonImageData(pokemonId: pokemonId, completion: { imageData in
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        })
    }
    
    func getPokemonIndex(pokemon:Pokemon) -> Int {
        let id = self.listOfPokemonDetail.firstIndex { detailEntity in
            detailEntity.pokemonDetail.id == pokemon.id
        }
        
        return id ?? 0
    }
    
    func getListOfPokemonDetails() -> [PokemonDetailDomainModel] {
        var listOfDetails = [PokemonDetailDomainModel]()
        
        self.listOfPokemonDetail.forEach { entity in
            listOfDetails.append(entity.pokemonDetail)
        }
        
        return listOfDetails
    }
}
