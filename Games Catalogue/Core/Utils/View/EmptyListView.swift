//
//  EmptyListView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 04/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Common

struct EmptyListView: View {
  
  var body: some View {
    
    VStack(spacing: 16) {
      Spacer()
      Image("undraw_empty")
        .resizable()
        .scaledToFit()
      
      Text("title_data_not_found".localized(identifier: "com.github.fajarazay.Common"))
        .fontWeight(.semibold)
        .font(.title)
      
      Text("subtitle_empty_game_favorite".localized(identifier: "com.github.fajarazay.Common"))
        .padding(.all, 16)
        .multilineTextAlignment(.center)
      Spacer()
      
    }
    
  }
}
