//
//  LocalDataSource.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
}
 
final class LocaleDataSource: NSObject {
 
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleDataSource = {
    realmDatabase in return LocaleDataSource(realm: realmDatabase)
  }
 
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "id", ascending: true)
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
 
  func addGames(
    from games: [GameEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in games {
              realm.add(game, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}
 
extension Results {
 
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
 
}
