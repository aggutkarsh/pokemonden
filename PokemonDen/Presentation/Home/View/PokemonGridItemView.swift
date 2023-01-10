//
//  PokemonGridItemView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct PokemonGridItemView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    let pokemonDetail: PokemonDetailDomainModel
    let pokemon: Pokemon
    
    @State var uiImage: UIImage?
    var body: some View {
        VStack {
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .scaledToFit()
                .padding(20)
                .frame(width: 150, height: 150, alignment: .center)

            Text("\(pokemon.name.capitalized)")
                .font(.custom("Roboto-Bold", size: 16))
                .foregroundColor(.black)
            
            Text(String(format: "%03d", pokemon.id))
                .font(.custom("Roboto-Medium", size: 16))
                .padding(.bottom, 16)
                .foregroundColor(.black)
            
        }
        .onAppear {
            vm.getPokemonImageData(pokemonId: pokemon.id) { image in
                DispatchQueue.main.async {
                    uiImage = image
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: vm.getListOfGradientColor(detail: pokemonDetail)), startPoint: .top, endPoint: .bottom).cornerRadius(8)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
        }
        
    }
}

struct PokemonGridItemView_Previews: PreviewProvider {
    static var sampleData:PokemonDetailDomainModel =  Bundle.main.decode(file: "pokemonDetails.json")
 
    static var previews: some View {
        PokemonGridItemView(pokemonDetail: sampleData, pokemon: Pokemon.samplePokemon)
            .environmentObject(HomeViewModel(useCase: HomeUseCase(repo: PokemonRepository(service: PokemonService(client: RESTClient(sessionDelegate: SSLPinningManager(isSSLPinningEnabled: true)))))))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
