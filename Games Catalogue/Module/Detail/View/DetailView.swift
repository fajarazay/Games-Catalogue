//
//  DetailView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    @ObservedObject var detailPresenter: DetailPresenter
    @State private var isExpanded: Bool = false
    @State private var isFlagFav: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading ) {
                    VStack {
                        WebImage(url: URL(string: detailPresenter.game.backgroundImage))
                            .resizable()
                            .placeholder {
                                ShimmerView()
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 320)
                        
                        ZStack(alignment: .topTrailing) {
                            
                            VStack(alignment: .leading) {
                                Text(detailPresenter.game.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                HStack(alignment: .top) {
                                    Text(detailPresenter.game.genres.reduce(
                                            "", { ($0.isEmpty ? "" : $0 + ", ") + $1.name!
                                            }))
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                }.padding(.top, 8)
                                
                                Text((detailPresenter.game.releasedDate).getFormattedDate)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 16))
                                    .padding(.vertical, 16)
                                
                                if !detailPresenter.loadingState && !detailPresenter.game.publishers.isEmpty {
                                    HStack(alignment: .center) {
                                        Text("Publishers")
                                            .font(.system(size: 16))
                                            .fontWeight(.bold)
                                        Text(detailPresenter.game.publishers.reduce(
                                                "", { ($0.isEmpty ? "" : $0 + ", ") + $1.name!
                                                }))
                                            .font(.system(size: 16))
                                    }.padding(.bottom, 16)
                                }
                                
                                if !detailPresenter.loadingState && !detailPresenter.game.description.isEmpty {
                                    Text(detailPresenter.game.description)
                                        .lineLimit(self.isExpanded ? nil : 2)
                                    
                                    Button {
                                        self.isExpanded.toggle()
                                    } label: {
                                        Text(self.isExpanded ? "Show Less..." : "Show More...")
                                            .foregroundColor(hexColor(0x00BFA6))
                                            .font(.system(size: 16)).bold()
                                            .padding(.top, 4)
                                            .background(Color.white)
                                    }.frame(alignment: .leading)
                                }
                                
                                Group {
                                    Text("Platforms")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                        .padding(.top, 24)
                                    
                                    VStack(alignment: .leading) {
                                        generateContent(in: geometry, data: detailPresenter.game.platforms)
                                        
                                    }.padding(.all, -8)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Reviews & Ratings")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                    
                                    HStack {
                                        Text(String(detailPresenter.game.rating))
                                            .font(.system(size: 54))
                                        
                                        VStack(alignment: .leading) {
                                            RatingView(rating: detailPresenter.game.rating)
                                            HStack {
                                                Text("\(detailPresenter.game.reviewsCount) reviews")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(Color.gray)
                                                Spacer()
                                            }
                                        }
                                    }
                                }.padding(.top, 24)
                                
                                Group {
                                    VStack(alignment: .leading) {
                                        Text("Available on ")
                                            .font(.system(size: 16))
                                            .fontWeight(.bold)
                                            .padding(.bottom, 16)
                                        
                                        ForEach(detailPresenter.game.stores) { store in
                                            Button {
                                                let urlDomain = String(describing: store.domain)
                                                if let url = URL(
                                                    string: "\(Constants.prefixUrlDomain)\(urlDomain)") {
                                                    UIApplication.shared.open(url)
                                                }
                                            } label: {
                                                Text(store.name ?? "")
                                                    .foregroundColor(ColorsManager.primary)
                                                    .font(.system(size: 16))
                                                    .fontWeight(.bold)
                                            }.padding(.bottom, 16)
                                        }
                                    }.padding(.top, 16)
                                }
                                
                            }.padding(.horizontal, 16)
                            .padding(.top, 32)
                            .background(Color.white)
                            .clipShape(RoundedShapeView())
                            .padding(.top, -48)
                            
                            Button {
                                if detailPresenter.isFavoriteGame {
                                    detailPresenter.setUnfavorite(game: detailPresenter.game)
                                } else {
                                    detailPresenter.setFavorite(game: detailPresenter.game)
                                }
                            } label: { Image(systemName: detailPresenter.isFavoriteGame
                                                ? "heart.fill" : "heart")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                                .padding()
                                .background(ColorsManager.primary)
                                .clipShape(Circle())
                                .shadow(color: Color.gray, radius: 12)
                                
                            }.padding(.top, -72)
                            .padding(.horizontal, 32)
                        }
                    }
                    Spacer()
                }.frame(minWidth: geometry.size.width, minHeight: geometry.size.height, maxHeight: .infinity)
            }.frame(minWidth: geometry.size.width, minHeight: geometry.size.height, maxHeight: .infinity)
        }.onAppear {
            detailPresenter.getGameDetail(gameId: detailPresenter.game.id)
        }.navigationBarTitle( "\(detailPresenter.game.name)", displayMode: .inline)
    }
}

private func generateContent(in geometry: GeometryProxy, data: [PlatformModel]) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    return ZStack(alignment: .topLeading) {
        ForEach(data) { platform in
            item(for: platform.name ?? "")
                .padding([.horizontal, .vertical], 8)
                .alignmentGuide(.leading, computeValue: { value in
                    if abs(width - value.width) > geometry.size.width {
                        width = 0
                        height -= value.height
                    }
                    let result = width
                    if platform == data.last! {
                        width = 0 // last item
                    } else {
                        width -= value.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {_ in
                    let result = height
                    if platform == data.last! {
                        height = 0 // last item
                    }
                    return result
                })
        }
    }
}

func item(for text: String) -> some View {
    Text(text)
        .padding(.all, 8)
        .font(.body)
        .background(hexColor(0x00BFA6))
        .foregroundColor(Color.white)
        .cornerRadius(5)
}
