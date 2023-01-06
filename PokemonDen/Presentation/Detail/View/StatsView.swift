//
//  StatsView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var detailVM: DetailViewModel
    
    let pokemonDetail: PokemonDetailDomainModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("Stats")
                .font(.custom("Roboto-Bold", size: 20))
                .foregroundColor(Colors.primary)
                .padding(.bottom, 5)
            
            StatItemView(statName: "HP", statValue: Float(detailVM.getStatValue("hp", pokemonDetail: pokemonDetail)))
            StatItemView(statName: "Attack", statValue: Float(detailVM.getStatValue("attack",pokemonDetail: pokemonDetail)))
            StatItemView(statName: "Defense", statValue: Float(detailVM.getStatValue("defense",pokemonDetail: pokemonDetail)))
            StatItemView(statName: "Speed", statValue: Float(detailVM.getStatValue("speed",pokemonDetail: pokemonDetail)))
            StatItemView(statName: "Sp. Attack", statValue: Float(detailVM.getStatValue("special-attack",pokemonDetail: pokemonDetail)))
            StatItemView(statName: "Sp. Def.", statValue: Float(detailVM.getStatValue("special-defense",pokemonDetail: pokemonDetail)))
        }
        .padding(.horizontal,42)
        .padding(.vertical, 24)
        .background(Colors.statBackground)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var sampleData:PokemonDetailDomainModel =  Bundle.main.decode(file: "pokemonDetails.json")
    static var previews: some View {
        StatsView(pokemonDetail: sampleData).environmentObject(DetailViewModel(useCase: DetailUseCase(repo: Repository(service: Services(client: RESTClient()), mapper: PokemonDetailMapper()))))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
