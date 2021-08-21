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
    
    let genres = List<GenreEntity>()
    let platforms = List<PlatformEntity>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
