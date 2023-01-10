//
//  HomeView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State var showFilter: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 0) {
                    HeaderView()
                    SearchBarView()
                    .padding(.vertical, 32)
                    
                    if homeVM.listOfPokemonDetail.count > 0 {
                        LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                            ForEach(homeVM.filteredPokemon) { pokemon in
                                NavigationLink {
                                    let id = homeVM.getPokemonIndex(pokemon: pokemon)
                                    
                                    DetailView(pokemonDetail:  homeVM.listOfPokemonDetail[id].pokemonDetail)
                                } label: {
                                    let id = homeVM.getPokemonIndex(pokemon: pokemon)
                            
                                    PokemonGridItemView( pokemonDetail: homeVM.listOfPokemonDetail[id].pokemonDetail, pokemon: pokemon)
                                }
                            }
                        }
                        .animation(.easeInOut(duration: 0.3), value: homeVM.filteredPokemon.count)
                    }
                }
                .padding(24)
            }
            .background(Colors.backGround)
            .hiddenNavigationBarStyle()
        }
        .onAppear{
            homeVM.getPokemonListModel()
        }
        .environmentObject(homeVM)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeVM: HomeViewModel(useCase: HomeUseCase(repo: PokemonRepository(service: PokemonService(client: RESTClient())))))
    }
}
