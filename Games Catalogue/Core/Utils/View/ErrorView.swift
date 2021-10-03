//
//  ErrorView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 04/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    @State var homePresenter: HomePresenter
    
    var body: some View {
        
        VStack(spacing: 16) {
            Spacer()
            Image("undraw_error")
                .resizable()
                .scaledToFit()
            Text("title_connection_failed".localized(identifier: "com.github.fajarazay.Common"))
                .fontWeight(.semibold)
                .font(.system(size: 24))
            
            Text("subtitle_connection_failed".localized(identifier: "com.github.fajarazay.Common"))
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
            
            Button {
                homePresenter.getGames()
            } label: {
                HStack {
                    Text("retry".localized(identifier: "com.github.fajarazay.Common"))
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                }
                .padding(16)
                .foregroundColor(.white)
                .background(hexColor(0x00BFA6))
                .cornerRadius(8)
            }
            Spacer()
        }
        
    }
}
