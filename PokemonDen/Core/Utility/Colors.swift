//
//  Colors.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 27/12/22.
//

import Foundation
import SwiftUI

struct Colors {
    static let backGround: Color = Color(hex: 0xDEEDED)
    static let primary: Color = Color(hex: 0x2E3156)
    static let progressViewBackgroud : Color = Color(hex: 0x93B2B2)
    static let statBackground: Color = Color(hex: 0xB0D2D2)
    static let searchBarBackground: Color = Color(hex: 0xC9DDE2)
    static let dividerColor: Color = Color(hex: 0x5D5F7E)
    static let dropShadow: Color = Color(hex:0x315666)
}

extension Color {
  init(hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}
