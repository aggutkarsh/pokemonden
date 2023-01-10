//
//  PokemonDenApp.swift
//  PokemonDen
//
//  Created by Utkarsh Agrawal on 06/01/23.
//

import SwiftUI

@main
struct PokemonDenApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(homeVM: HomeViewModel(useCase: HomeUseCase(repo: PokemonRepository(service: PokemonService(client: RESTClient(sessionDelegate: SSLPinningManager(isSSLPinningEnabled: true)))))))
        }
    }
}
