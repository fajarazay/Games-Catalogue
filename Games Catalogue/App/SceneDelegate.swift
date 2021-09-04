//
//  SceneDelegate.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import UIKit
import Cleanse

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let propertyInjector = try? ComponentFactory.of(AppComponent.self).build((scene))
        propertyInjector?.injectProperties(into: self)
        precondition(window != nil)
        window!.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    func injectProperties(_ window: UIWindow) {
        self.window = window
    }
}
