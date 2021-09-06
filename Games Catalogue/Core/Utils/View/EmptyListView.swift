//
//  EmptyListView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 04/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct EmptyListView: View {
  
  var body: some View {
    
    VStack(spacing: 16) {
      Spacer()
      Image("undraw_empty")
        .resizable()
        .scaledToFit()
      
      Text("Data Not Found")
        .fontWeight(.semibold)
        .font(.title)
      
      Text("You haven't add any game as your favorite")
        .padding(.all, 16)
        .multilineTextAlignment(.center)
      Spacer()
      
    }
    
  }
}
