//
//  AppComponent.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 04/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Cleanse
import UIKit

struct AppComponent: Cleanse.RootComponent {
    typealias Root = PropertyInjector<SceneDelegate>
    typealias Seed = UIScene
    
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: CoreAppModule.self)
        binder.include(module: RootWindowModule.self)
        binder.include(module: HomePresenter.Module.self)
        binder.include(module: FavoritePresenter.Module.self)
    }

    static func configureRoot(
        binder bind: ReceiptBinder<PropertyInjector<SceneDelegate>>
    ) -> BindingReceipt<PropertyInjector<SceneDelegate>> {
        bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<SceneDelegate>> in
            bind.to(injector: SceneDelegate.injectProperties)
        }
    }
}

struct CoreAppModule: Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: FoundationCommonModule.self)
    }
}
