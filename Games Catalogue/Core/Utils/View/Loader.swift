//
//  Loader.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct Loader: View {
  
  @State var animate = false
  
  var body: some View {
    VStack {
      Circle()
        .stroke(AngularGradient(gradient: .init(colors:[ColorsManager.primary, (ColorsManager.primary)]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
        .frame(width: 45, height: 45)
        //.rotationEffect(.init(degrees: self.animate ? 90: 0))
        .onAppear {
            let baseAnimation = Animation.linear(duration: 3)
                        let repeated = baseAnimation.repeatForever(autoreverses: true)

                        withAnimation(repeated) {
                            animate.toggle()
                        }
                    }
    }
  }
}
