//
//  HomeViewModelTests.swift
//  PokémonDenTests
//
//  Created by Utkarsh Agrawal on 29/12/22.
//

import XCTest
import SwiftUI
@testable import PokémonDen

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var useCase: HomeUseCase!
    var mockRepo: MockRepository!
    
    override func setUp() {
        mockRepo = MockRepository(service: Services(client: RESTClient()), mapper: ListOfPokemonMapper())
        useCase = HomeUseCase(repo: mockRepo)
        viewModel = HomeViewModel(useCase: useCase)
    }

    func test_getPokemonTypes() {
        var response: [String]?
        var detail: PokemonDetailDomainModel?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
            
        // ACT
        response = viewModel.getPokemonTypes(detail: detail!)
            
        // ASSERT
        XCTAssertEqual(response?.count, 2, "Count is equal")
    }
    
    func test_getListOfGradientColor() {
        var response: [Color]?
        var detail: PokemonDetailDomainModel?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
            
        // ACT
        response = viewModel.getListOfGradientColor(detail: detail!)
            
        // ASSERT
        XCTAssertNotEqual(response?.count, 1, "Count is not equal")
    }
    
    func test_getPokemonIndex() {
        var response: Int?
        var detail, anotherDetail: PokemonDetailDomainModel?
        var pokemon: Pokemon?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
        anotherDetail = Bundle.main.decode(file: "anotherPokemonDetails.json")
        viewModel.listOfPokemonDetail.append(ListOfPokemonDetailEntity(id: 6, pokemonDetail: detail!, listOfType: []))
        viewModel.listOfPokemonDetail.append(ListOfPokemonDetailEntity(id: 7, pokemonDetail: anotherDetail!, listOfType: []))
        pokemon = Pokemon(id: 7, name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/")
            
        // ACT
        response = viewModel.getPokemonIndex(pokemon: pokemon!)
            
        // ASSERT
        XCTAssertEqual(response, 1)
    }
}
