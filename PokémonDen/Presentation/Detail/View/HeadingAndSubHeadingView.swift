//
//  HeadingAndSubHeadingView.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import SwiftUI

struct HeadingAndSubHeadingView: View {
    let heading: String
    let subHeading: String
    var headingFontSize: CGFloat = 16
    var subHeadingFontSize: CGFloat = 16
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(heading)
                .font(.custom("Roboto-Bold", size: headingFontSize))
                .foregroundColor(Colors.primary)
            
            Text(subHeading)
                .font(.custom("Roboto-Regular", size: subHeadingFontSize))
                .foregroundColor(Colors.primary)
        }
    }
}

struct HeadingAndSubHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingAndSubHeadingView(heading: "Heading", subHeading: "Sub-Heading")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
