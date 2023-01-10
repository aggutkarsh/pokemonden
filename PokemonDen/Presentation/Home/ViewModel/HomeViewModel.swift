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
    @Published var errorText = ""
    
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
        useCase?.getListOfPokemon({ [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.listOfPokemonModel = data
                        data?.listOfPokemon.forEach({ pokemon in
                            self?.getDetails(pokemonIndex: pokemon.id)
                        })
                    }
                case .failure(let error):
                    self?.errorText = "Unable to fetch Pokemon(s) Data!"
            }
        })
    }
    
    func getDetails(pokemonIndex: Int) {
        useCase?.getDetails(id: pokemonIndex, { result in
            switch result {
                case .success(let details):
                    DispatchQueue.main.async {
                        self.listOfPokemonDetail.append(ListOfPokemonDetailEntity(id: pokemonIndex, pokemonDetail: details!, listOfType: []))
                    }
                case .failure(let error):
                    self.errorText = "Unable to retrieve Pokemon(Id: \(pokemonIndex)) Details!"
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
        useCase?.getPokemonImageData(pokemonId: pokemonId, completion: { result in
            switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        completion(UIImage(data: imageData))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(UIImage(named: "placeHolder"))
                    }
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
