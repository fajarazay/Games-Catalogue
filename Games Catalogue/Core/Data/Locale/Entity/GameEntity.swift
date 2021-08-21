//
//  GameEntity.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var rating: Double = 0
    @objc dynamic var desc: String = ""
    @objc dynamic var reviewsCount: Int = 0

    let publishers = List<PublisherEntity>()
    let genres = List<GenreEntity>()
    let platforms = List<PlatformEntity>()
    let stores = List<StoreEntity>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
