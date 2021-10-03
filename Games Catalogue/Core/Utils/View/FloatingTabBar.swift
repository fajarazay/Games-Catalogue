//
//  FloatingTabBar.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 13/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Common

struct FloatingTabBar: View {
    
    @Binding var selected: Int
    @Binding var titleBar: String
    
    @State var expand = false
    
    var body : some View {
        
        HStack {
            
            Spacer(minLength: 0)
            
            HStack {
                
                if !self.expand {
                    Button {
                        self.expand.toggle()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                } else {
                    Spacer()
                    Button {
                        self.selected = 0
                        self.titleBar = "home".localized(identifier: "com.github.fajarazay.Common")
                    } label: {
                        Image(systemName: "house.fill")
                            .foregroundColor(self.selected == 0 ? .white : ColorsManager.greyLight)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 1
                        self.titleBar = "favorites".localized(identifier: "com.github.fajarazay.Common")
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(self.selected == 1 ? .white : ColorsManager.greyLight)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 2
                        self.titleBar = "profile".localized(identifier: "com.github.fajarazay.Common")
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundColor(self.selected == 2 ? .white : ColorsManager.greyLight)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.expand.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .foregroundColor(ColorsManager.greyLight)
                    }
                    
                    Spacer()
                }
                
            }
            .frame(width: self.expand ? nil : 48, height: 48)
            .background(ColorsManager.primary)
            .clipShape(Capsule())
            .padding(.vertical, 0)
            .padding(.horizontal, self.expand ? 48: 24)
            .shadow(color: Color.gray, radius: 5)
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6), value: expand)
        }
    }
}
