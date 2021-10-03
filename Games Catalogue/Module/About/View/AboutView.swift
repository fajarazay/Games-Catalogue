//
//  AboutView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 14/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Common

struct AboutView: View {

    var body: some View {
      VStack(spacing: 16) {
        Image("profile_picture")
          .resizable()
          .frame(width: 200, height: 200)
          .clipShape(Circle())
        Text("Fajar Septian")
          .font(.largeTitle)
      }
      .navigationBarTitle("profile".localized(identifier: "com.github.fajarazay.Common"), displayMode: .inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
