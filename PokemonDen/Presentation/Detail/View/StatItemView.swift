//
//  StatItemView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct StatItemView: View {
    let statName:String
    let statValue: Float
    
    var body: some View {
        HStack{
            Text(statName)
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(Colors.primary)
                .frame(width: 80,alignment: .leading)
            
            ProgressBarView(value: statValue)
                .frame(height: 13)
        }
    }
}

struct StatItemView_Previews: PreviewProvider {
    static var previews: some View {
        StatItemView(statName: "Sp. Attack", statValue: Float(40))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
