//
//  SearchBarView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        TextField("Name or Number", text: $homeVM.searchText)
                .padding(12)
                .cornerRadius(8)
                .background(Colors.searchBarBackground.cornerRadius(8))
                .frame(height: 52)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(width: 16,height: 16)
                            .padding(.trailing, 24)
                    }
                )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(HomeViewModel(useCase: HomeUseCase(repo: PokemonRepository(service: PokemonService(client: RESTClient())))))
    }
}
