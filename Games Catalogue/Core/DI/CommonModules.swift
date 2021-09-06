//
//  CommonModules.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 04/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import Cleanse
import SwiftUI

struct FoundationCommonModule: Module {
    static func configure(binder: Binder<Singleton>) {
        binder
            .bind(ProcessInfo.self)
            .to { ProcessInfo.processInfo }
    }
}

struct RootWindowModule: Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: HomeInteractor.Module.self)
        binder.include(module: FavoriteInteractor.Module.self)
        binder
            .bind(UIWindow.self)
            .to { (rootViewController: TaggedProvider<UIViewController.Root>, scene: UIScene) -> UIWindow in
                guard let windowScene = scene as? UIWindowScene else {
                    fatalError()
                }
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = rootViewController.get()
                return window
            }
        
        binder
            .bind()
            .tagged(with: UIViewController.Root.self)
            .to { (homeInteractor: Provider<HomeInteractor>,
                   homeRouter: Provider<HomeRouter>,
                   favoriteInteractor: Provider<FavoriteInteractor>,
                   favoriteRouter: Provider<FavoriteRouter>) -> UIViewController in
                let contentView = ContentView()
                    .environmentObject(HomePresenter(
                        homeUseCase: homeInteractor.get(),
                        homeRouter: homeRouter.get()
                    ))
                    .environmentObject(FavoritePresenter(
                        favoriteUseCase: favoriteInteractor.get(),
                        favoriteRouter: favoriteRouter.get()
                    ))
                
                return UIHostingController(rootView: contentView)
            }
    }
}

extension UIViewController {
    
    public struct Root: Tag {
        public typealias Element = UIViewController
    }
    
}
