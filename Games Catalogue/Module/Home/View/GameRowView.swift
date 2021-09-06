//
//  GameRow.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRowView: View {
    
    var game: GameModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Group {
                HStack {
                    WebImage(url: URL(string: game.backgroundImage))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 160)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(game.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Text((self.game.releasedDate).getFormattedDate)
                            .foregroundColor(Color.gray)
                            .font(.footnote)
                        
                        Spacer()
                        
                        Text(game.genres.reduce(
                                "", { ($0.isEmpty ? "" : $0 + ", ") + $1.name!
                                }))
                            .lineLimit(1)
                            .font(.caption)
                        
                        Spacer()
                        
                        RatingView(rating: game.rating)
                        
                        Spacer()
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(game.platforms) { platform in
                                    ChipsView(text: platform.name ?? "")
                                }
                            }.padding(.all, 8)
                        }.padding(.horizontal, -8)
                    }.padding(.all, 8)
                    
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
            }
        }.overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(ColorsManager.line, lineWidth: 0.5)
        ).background(
            RoundedRectangle(
                cornerRadius: 8
            ).foregroundColor(Color.white).shadow(
                color: ColorsManager.line,
                radius: 8,
                x: 0,
                y: 8
            )
        ).padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
    
}

extension GameRowView {
    
    var imageGame: some View {
        WebImage(url: URL(string: game.backgroundImage))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding(.top)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(game.genres.reduce(
                    "", { ($0.isEmpty ? "" : $0 + ", ") + $1.name!
                    }))
                .lineLimit(1)
                .font(.caption)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
    
}
