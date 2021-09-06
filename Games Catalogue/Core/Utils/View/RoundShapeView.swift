//
//  RoundShapeView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct RoundedShapeView: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
    
}
