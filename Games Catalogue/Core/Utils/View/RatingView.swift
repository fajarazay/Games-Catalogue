//
//  RatingView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    
    @State var rating: Double
    
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var halfImage = Image(systemName: "star.lefthalf.fill")
    var offColor = ColorsManager.greyLight
    var onColor = ColorsManager.primary
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating+1) { number in
                self.image(for: number)
                    .foregroundColor(Double(number) >= self.rating+1 ? self.offColor : self.onColor)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        
        if Double(number) >= rating+1 {
            return onImage
        } else if Double(number) > rating {
            return halfImage
        } else {
            return onImage
        }
    }
}
