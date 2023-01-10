//
//  DetailUseCaseTests.swift
//  PokémonDenTests
//
//  Created by Utkarsh Agrawal on 29/12/22.
//

import XCTest
@testable import PokemonDen

class DetailUseCaseTests: XCTestCase {
    
    var useCase: DetailUseCase!
    var mockRepo: MockRepository!
    
    override func setUp() {
        mockRepo = MockRepository(service: PokemonService(client: RESTClient()))
        useCase = DetailUseCase(repo: mockRepo)
    }

    func test_getPokemonDesc() {
        var response: PokemonDescDomainModel?
            
        // ACT
        useCase.getPokemonDesc(id: 6, { result in
            switch result {
                case .success(let data):
                    response = data
                case .failure(_):
                    response = nil
            }
        })
            
        // ASSERT
        XCTAssertEqual(response?.eggGroup.count, 2, "EggGroup count is equal")
        XCTAssertEqual(response?.evolutionChain.url, "https://pokeapi.co/api/v2/evolution-chain/2/", "EvolutionChain URL is matching")
        XCTAssertNotEqual(response?.flavorTextEntries.count, 3, "FlavorTextEntries count is not matching")
    }
}
