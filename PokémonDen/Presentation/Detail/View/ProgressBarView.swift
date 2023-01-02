//
//  ProgressBarView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct ProgressBarView: View {
    let value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .foregroundColor(Colors.progressViewBackgroud)
                
                Rectangle().frame(width: min(CGFloat(self.value/100) * geometry.size.width, geometry.size.width) , height: geometry.size.height)
                    .foregroundColor(Colors.primary)
                    .animation(.linear, value: value)
                
                Text("\(Int(value))")
                    .font(.custom("Roboto-Bold", size: 10))
                    .foregroundColor(.white)
                    .padding(.leading, 5)
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(value: Float(10))
            .frame(height: 20)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
