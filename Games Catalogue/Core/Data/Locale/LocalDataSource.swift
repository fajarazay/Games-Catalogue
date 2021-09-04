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
import Cleanse

protocol LocaleDataSourceProtocol: AnyObject {
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func getFavGames() -> AnyPublisher<[GameEntity], Error>
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameEntity, Error>
    
    func addGameDetail(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
    
    func setFavorite(from games: GameEntity) -> AnyPublisher<Bool, Error>
    func setUnfavorite(from games: GameEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getFavGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                print("User Realm file location: \(realm.configuration.fileURL!.path)")
                
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .filter("isFavorite == true")
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func setFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                print("User Realm file location: \(realm.configuration.fileURL!.path)")
                
                do {
                    try realm.write {
                        game.isFavorite = true
                        realm.add(game, update: .all)
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
    
    func setUnfavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                print("User Realm file location: \(realm.configuration.fileURL!.path)")
                
                do {
                    try realm.write {
                        game.isFavorite = false
                        realm.add(game, update: .all)
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
    
    func addGameDetail(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                print("User Realm file location: \(realm.configuration.fileURL!.path)")
                
                do {
                    try realm.write {
                        realm.add(game, update: .all)
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
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            if let realmDB = self.realm {
                let gameResult: Results<GameEntity> = {
                    realmDB.objects(GameEntity.self)
                        .filter("id == \(gameId)")
                }()
                
                guard let game = gameResult.first else {
                    return
                }
                
                completion(.success(game))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                print("User Realm file location: \(realm.configuration.fileURL!.path)")
                
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
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
                print("User Realm file location: \(realm.configuration.fileURL!.path)")
                
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

extension LocaleDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(LocaleDataSource.self).to { () -> LocaleDataSource in
                LocaleDataSource.init(realm: try? Realm()) }
        }
    }
}
