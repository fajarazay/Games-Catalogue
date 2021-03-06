//
//  UIColor.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

prefix operator ⋮
prefix func ⋮ (hex: UInt32) -> Color {
    return Color(hex)
}

extension Color {
    init(_ hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let hexColor: (UInt32) -> (Color) = {
    return Color($0)
}
