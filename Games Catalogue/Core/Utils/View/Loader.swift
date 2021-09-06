//
//  Loader.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct Loader: View {
    
    @State var degrees: CGFloat = 0
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(
                AngularGradient(
                    gradient: .init(
                        colors: [
                            ColorsManager.primary,
                            ColorsManager.primaryLight
                        ]
                    ),
                    center: .center),
                style: StrokeStyle(
                    lineWidth: 8,
                    lineCap: .round
                )
            )
            .frame(width: 45, height: 45)
            .rotationEffect(Angle(degrees: Double(degrees)))
            .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false), value: degrees)
            .onAppear {
                DispatchQueue.main.async {
                    degrees = 360
                }
            }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
