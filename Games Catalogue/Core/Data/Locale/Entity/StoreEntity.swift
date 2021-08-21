//
//  StoreEntity.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 21/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import RealmSwift

class StoreEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var domain: String = ""
}
