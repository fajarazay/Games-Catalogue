//
//  ChipsView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct ChipsView: View {
    let text: String
    let lineLimit: Int? = nil
    
    var body: some View {
        HStack {
            Text(text)
                .lineLimit(lineLimit)
                .font(.system(size: 12))
            
        }.padding(.all, 8)
        .foregroundColor(ColorsManager.primary)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(ColorsManager.primary, lineWidth: 1)
        )
    }
}
