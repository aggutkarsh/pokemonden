//
//  HomeUseCaseTests.swift
//  PokémonDenTests
//
//  Created by Utkarsh Agrawal on 28/12/22.
//

import XCTest
@testable import PokemonDen

class HomeUseCaseTests: XCTestCase {

    var useCase: HomeUseCase!
    var mockRepo: MockRepository!
    
    override func setUp() {
        mockRepo = MockRepository(service: Services(client: RESTClient()), mapper: ListOfPokemonMapper())
        useCase = HomeUseCase(repo: mockRepo)
    }
    
    func test_getListOfPokemon() {
        var response: ListOfPokemonDomainModel?
            
        // ACT
        useCase.getListOfPokemon({ data in
            response = data
        })
            
        // ASSERT
        XCTAssertEqual(response?.listOfPokemon.count, 20, "Count is equal")
        XCTAssertNotEqual(response?.listOfPokemon[2].name, "venusur", "Name is not matching")
        XCTAssertEqual(response?.listOfPokemon[0].name, "bulbasaur", "Name is matching")
    }
    
    func test_getDetails() {
        var response: PokemonDetailDomainModel?
        
        // ARRANGE
        mockRepo.mapper = PokemonDetailMapper()
            
        // ACT
        useCase.getDetails(id: 6, { data in
            response = data
        })
            
        // ASSERT
        XCTAssertEqual(response?.height, 17, "Height is equal")
        XCTAssertNotEqual(response?.types.count, 1, "Types count is not matching")
    }
}
