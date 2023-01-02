//
//  DetailViewModelTests.swift
//  PokémonDenTests
//
//  Created by Utkarsh Agrawal on 29/12/22.
//

import XCTest
import SwiftUI
@testable import PokémonDen

class DetailViewModelTests: XCTestCase {

    var viewModel: DetailViewModel!
    var useCase: DetailUseCase!
    var mockRepo: MockRepository!
    
    override func setUp() {
        mockRepo = MockRepository(service: Services(client: RESTClient()), mapper: PokemonDescMapper())
        useCase = DetailUseCase(repo: mockRepo)
        viewModel = DetailViewModel(useCase: useCase)
    }

    func test_getStatValue() {
        var response: Int?
        var detail: PokemonDetailDomainModel?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
        
        // ACT
        response = viewModel.getStatValue("special-attack", pokemonDetail: detail!)
            
        // ASSERT
        XCTAssertEqual(response, 109)
        XCTAssertNotEqual(response, 84)
    }
    
    func test_getPokemonEggGroup() {
        var response: String?
        
        // ARRANGE
        viewModel.pokemonDesc = Bundle.main.decode(file: "pokemonSpecies.json")
        
        // ACT
        response = viewModel.getPokemonEggGroup()
            
        // ASSERT
        XCTAssertEqual(response, "Monster, Dragon")
    }
    
    func test_getPokemonAbilities() {
        var response: String?
        var detail: PokemonDetailDomainModel?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
        
        // ACT
        response = viewModel.getPokemonAbilities(pokemonDetail: detail!)
            
        // ASSERT
        XCTAssertNotEqual(response, "blaze, solar-power")
        XCTAssertEqual(response, "Blaze, Solar-Power")
    }
    
    func test_getPokemonTypes() {
        var response: [String]?
        var detail: PokemonDetailDomainModel?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
            
        // ACT
        response = viewModel.getPokemonTypes(pokemonDetail: detail!)
            
        // ASSERT
        XCTAssertNotEqual(response?.count, 1, "Count is not equal")
    }
    
    func test_getListOfGradientColor() {
        var response: [Color]?
        var detail: PokemonDetailDomainModel?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
            
        // ACT
        response = viewModel.getListOfGradientColor(pokemonDetail: detail!)
            
        // ASSERT
        XCTAssertEqual(response?.count, 2, "Count is equal")
    }
    
    func test_getPokemonIndex() {
        var response: Int?
        var detail, anotherDetail: PokemonDetailDomainModel?
        var pokemon: Pokemon?
        
        // ARRANGE
        detail = Bundle.main.decode(file: "pokemonDetails.json")
        anotherDetail = Bundle.main.decode(file: "anotherPokemonDetails.json")
        pokemon = Pokemon(id: 6, name: "charizard", url: "https://pokeapi.co/api/v2/pokemon/6/")
            
        // ACT
        response = viewModel.getPokemonIndex(pokemon: pokemon!, listOfPokemonDetail: [detail!, anotherDetail!])
            
        // ASSERT
        XCTAssertEqual(response, 0)
    }
}
