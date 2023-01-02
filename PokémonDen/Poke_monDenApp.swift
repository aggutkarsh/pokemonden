//
//  Poke_monDenApp.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import SwiftUI

@main
struct Poke_monDenApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(homeVM: HomeViewModel(useCase: HomeUseCase(repo: Repository(service: Services(client: RESTClient()), mapper: ListOfPokemonMapper()))))
        }
    }
}
