//
//  HeaderView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PokémonDen")
                .font(.custom("Roboto-Bold", size: 35))
                .foregroundColor(Colors.primary)
            
            Rectangle()
                .fill(Colors.dividerColor)
                .frame(height: 1)
                .padding(.trailing, 16)
            
            Text("Search for any Pokémon that exists on the planet")
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(Colors.dividerColor)
                .multilineTextAlignment(.leading)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
            .padding()
            
    }
}
