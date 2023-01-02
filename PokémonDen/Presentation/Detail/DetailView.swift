//
//  DetailView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailVM = DetailViewModel(useCase: DetailUseCase(repo: Repository(service: Services(client: RESTClient()), mapper: PokemonDetailMapper())))
    
    let pokemonDetail: PokemonDetailDomainModel
    let listOfPokemon: [Pokemon]
    let listOfPokemonDetail: [PokemonDetailDomainModel]
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // MARK: - Name Header
                VStack(alignment: .leading, spacing: 32) {
                    HStack(alignment: .top) {
                        HeadingAndSubHeadingView(heading: pokemonDetail.name.uppercased(), subHeading: String(format: "%03d", pokemonDetail.id ), headingFontSize: 30, subHeadingFontSize: 30)
                        Spacer()
                        Image(systemName: "multiply.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25,height: 25)
                            .foregroundColor(Colors.primary)
                            .onTapGesture {
                                self.mode.wrappedValue.dismiss()
                            }
                    }
                    
                    ImageAndDescriptionView(pokemonDetail: pokemonDetail)
                        .frame(height: 200)
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 32) {
                            HeadingAndSubHeadingView(heading: "Height", subHeading: "\(String(pokemonDetail.height))'")
                            
                            HeadingAndSubHeadingView(heading: "Gender(s)", subHeading: "Male, Female")
                            
                            HeadingAndSubHeadingView(heading: "Abilities", subHeading: "\(String(detailVM.getPokemonAbilities(pokemonDetail: pokemonDetail)))")
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 32) {
                            HeadingAndSubHeadingView(heading: "Weight", subHeading: "\(String(pokemonDetail.weight)) Kg")
                            
                            HeadingAndSubHeadingView(heading: "Egg Groups", subHeading: "\(String(detailVM.getPokemonEggGroup()))")
                            
                            PokemonTypeView(heading: "Types", listOfData: detailVM.getPokemonTypes(pokemonDetail: pokemonDetail))
                        }
                    }
                }
                .padding(.horizontal,24)
                StatsView(pokemonDetail: pokemonDetail)
                    .padding(.top, 40)
                
                Spacer()
            }
            .padding(.vertical, 32)
            .hiddenNavigationBarStyle()
        }
        .background(Colors.backGround)
        .environmentObject(detailVM)
        .onAppear{
            detailVM.getPokemonDesc(pokemonIndex: pokemonDetail.id)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData:PokemonDetailDomainModel =  Bundle.main.decode(file: "pokemonDetails.json")
    static var previews: some View {
        DetailView(pokemonDetail: sampleData, listOfPokemon: [Pokemon.samplePokemon], listOfPokemonDetail: [sampleData])
    }
}
