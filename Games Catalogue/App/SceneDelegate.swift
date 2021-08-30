//
//  SceneDelegate.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let homeUseCase = Injection.init().provideHome()

    let homePresenter = HomePresenter(homeUseCase: homeUseCase)

    let favoriteUseCase = Injection.init().provideFavorite()

    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
    
    let contentView = ContentView()
     .environmentObject(homePresenter)
     .environmentObject(favoritePresenter)

    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
}
