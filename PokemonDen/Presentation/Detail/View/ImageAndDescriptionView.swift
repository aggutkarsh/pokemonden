//
//  ImageAndDescriptionView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct ImageAndDescriptionView: View {
    @EnvironmentObject var detailVM: DetailViewModel
    
    let pokemonDetail: PokemonDetailDomainModel
    @State var uiImage: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top) {
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal,16)
                    .padding(.vertical,42)
                    .background(
                        LinearGradient(gradient: Gradient(colors: detailVM.getListOfGradientColor(pokemonDetail: pokemonDetail)), startPoint: .top, endPoint: .bottom).cornerRadius(8)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    }
                
                Text(detailVM.pokemonDesc?.flavorTextEntries.first?.flavorText ?? "")
                    .font(.custom("Roboto-Regular", size: 18))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Colors.primary)
                    .padding(.leading,24)
                
            }
            .onAppear {
                detailVM.getPokemonImageData(pokemonId: pokemonDetail.id) { image in
                    DispatchQueue.main.async {
                        uiImage = image
                    }
                }
            }
        }
    }
}

struct ImageAndDescriptionView_Previews: PreviewProvider {
    static var sampleData:PokemonDetailDomainModel =  Bundle.main.decode(file: "pokemonDetails.json")
    static var previews: some View {
        ImageAndDescriptionView(pokemonDetail: sampleData)
            .environmentObject(DetailViewModel(useCase: DetailUseCase(repo: PokemonRepository(service: PokemonService(client: RESTClient(sessionDelegate: SSLPinningManager(isSSLPinningEnabled: true)))))))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
