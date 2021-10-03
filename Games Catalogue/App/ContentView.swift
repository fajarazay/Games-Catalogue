//
//  ContentView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Cleanse
import Common

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    @State var selected = 0
    @State var titleBar = "Home"
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    
                    VStack {
                        if self.selected == 0 {
                            HomeView(presenter: homePresenter)
                        } else if self.selected == 1 {
                            FavoriteView(presenter: favoritePresenter)
                        } else {
                            AboutView()
                        }
                    }
                    VStack {
                        Spacer()
                        FloatingTabBar(selected: self.$selected, titleBar: self.$titleBar)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
