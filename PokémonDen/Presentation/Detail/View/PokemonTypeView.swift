//
//  PokemonTypeView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct PokemonTypeView: View {
    let heading: String
    let listOfData: [String]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 6){
            Text(heading)
                .font(.custom("Roboto-Bold", size: 16))
                .foregroundColor(Colors.primary)
                .padding(0)
            
            HStack(alignment: .top){
                ForEach(listOfData, id: \.self) { data in
                    Text(data.localizedCapitalized)
                        .font(.custom("Roboto-Regular", size: 16))
                        .padding(.horizontal,6)
                        .padding(.vertical,2)
                        .background(Color(data.localizedCapitalized))
                        .foregroundColor(Colors.primary)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                        }
                }
            }
            
        }
    }
}

struct PokemonTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeView(heading: "Type", listOfData: ["String"])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
