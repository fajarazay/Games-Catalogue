//
//  GameMapper.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

final class GameMapper {
    
    static func mapGameResponsesToDomains(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        
        return gameResponses.map { result in
            return GameModel(
                id: result.id,
                name: result.name ?? "Unknown",
                backgroundImage: result.backgroundImage ?? "",
                releasedDate: result.released ?? "",
                rating: result.rating ?? 0,
                reviewsCount: result.reviewsCount ?? 0,
           
                genres: result.genres?.map { genre in
                    return GenreModel(id: genre.id, name: genre.name)
                } ?? [] ,
                platforms: result.platforms?.map { platforms in
                    return PlatformModel(id: platforms.platform?.id, name: platforms.platform?.name)
                } ?? [],
                stores: result.stores?.map { stores in
                    return StoreModel(id: stores.store?.id, name: stores.store?.name, domain: stores.store?.domain)
                } ?? []
            )
        }
    }
    
    static func mapGameResponsesToEntities(
        input gameResponses: [GameResponse]
    ) -> [GameEntity] {
        return gameResponses.map { result in
            let newGame = GameEntity()
            newGame.id = result.id
            newGame.name = result.name ?? "unknown"
            newGame.image = result.backgroundImage ?? ""
            newGame.releaseDate = result.released ?? ""
            newGame.rating = result.rating ?? 0
            newGame.reviewsCount = result.reviewsCount ?? 0
            
            for responseGenre in result.genres ?? [] {
                let genreEntity = GenreEntity()
                genreEntity.id = responseGenre.id ?? 0
                genreEntity.name = responseGenre.name ?? ""
                newGame.genres.append(genreEntity)
            }
            
            for responsePlatform in result.platforms ?? [] {
                let platformEntity = PlatformEntity()
                platformEntity.id = responsePlatform.platform?.id ?? 0
                platformEntity.name = responsePlatform.platform?.name ?? ""
                newGame.platforms.append(platformEntity)
            }

            for responseStore in result.stores ?? [] {
                let storeEntity = StoreEntity()
                storeEntity.id = responseStore.store?.id ?? 0
                storeEntity.name = responseStore.store?.name ?? ""
                storeEntity.domain = responseStore.store?.domain ?? ""
                newGame.stores.append(storeEntity)
            }
            return newGame
        }
    }
    
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                backgroundImage: result.image,
                releasedDate: result.releaseDate,
                rating: result.rating,
                description: result.desc,
                reviewsCount: result.reviewsCount,
                isFavorite: result.isFavorite,
                genres: result.genres.map { genre in
                    return GenreModel(id: genre.id, name: genre.name)
                },
                platforms: result.platforms.map { platforms in
                    return PlatformModel(id: platforms.id, name: platforms.name)
                },
                publishers: result.publishers.map { publisher in
                    return PublisherModel(id: publisher.id, name: publisher.name)
                },
                stores: result.stores.map { store in
                    return StoreModel(id: store.id, name: store.name, domain: store.domain)
                }
            )
        }
    }
    
    static func mapGameDetailResponseToEntity(
        input gameResponse: GameResponse
    ) -> GameEntity {
        let result = gameResponse
        let newGame = GameEntity()
        newGame.id = result.id
        newGame.name = result.name ?? "unknown"
        newGame.image = result.backgroundImage ?? ""
        newGame.releaseDate = result.released ?? ""
        newGame.rating = result.rating ?? 0
        newGame.desc = result.description ?? ""
        newGame.reviewsCount = result.reviewsCount ?? 0
        
        for responseGenre in result.genres ?? [] {
            let genreEntity = GenreEntity()
            genreEntity.id = responseGenre.id ?? 0
            genreEntity.name = responseGenre.name ?? ""
            newGame.genres.append(genreEntity)
        }
        
        for responsePlatform in result.platforms ?? [] {
            let platformEntity = PlatformEntity()
            platformEntity.id = responsePlatform.platform?.id ?? 0
            platformEntity.name = responsePlatform.platform?.name ?? ""
            newGame.platforms.append(platformEntity)
        }
        
        for responsePublisher in result.publishers ?? [] {
            let publisherEntity = PublisherEntity()
            publisherEntity.id = responsePublisher.id ?? 0
            publisherEntity.name = responsePublisher.name ?? ""
            newGame.publishers.append(publisherEntity)
        }
        
        for responseStore in result.stores ?? [] {
            let storeEntity = StoreEntity()
            storeEntity.id = responseStore.store?.id ?? 0
            storeEntity.name = responseStore.store?.name ?? ""
            storeEntity.domain = responseStore.store?.domain ?? ""
            newGame.stores.append(storeEntity)
        }
        
        return newGame
    }
    
    static func mapGameDetailEntityToDomain(
        input gameEntity: GameEntity
    ) -> GameModel {
        return GameModel(
            id: gameEntity.id,
            name: gameEntity.name,
            backgroundImage: gameEntity.image,
            releasedDate: gameEntity.releaseDate,
            rating: gameEntity.rating,
            description: gameEntity.desc,
            reviewsCount: gameEntity.reviewsCount,
            isFavorite: gameEntity.isFavorite,
            genres: gameEntity.genres.map { genre in
                return GenreModel(id: genre.id, name: genre.name)
            },
            platforms: gameEntity.platforms.map { platforms in
                return PlatformModel(id: platforms.id, name: platforms.name)
            },
            publishers: gameEntity.publishers.map { publisher in
                return PublisherModel(id: publisher.id, name: publisher.name)
            },
            stores: gameEntity.stores.map { store in
                return StoreModel(id: store.id, name: store.name, domain: store.domain)
            }
        )
    }
    
    static func mapGameDomainToEntity(
        input gameModel: GameModel
    ) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = gameModel.id
        newGame.name = gameModel.name
        newGame.image = gameModel.backgroundImage
        newGame.releaseDate = gameModel.releasedDate
        newGame.rating = gameModel.rating
        newGame.desc = gameModel.description
        newGame.reviewsCount = gameModel.reviewsCount
        newGame.isFavorite = gameModel.isFavorite
        
        for genre in gameModel.genres {
            let genreEntity = GenreEntity()
            genreEntity.id = genre.id ?? 0
            genreEntity.name = genre.name ?? ""
            newGame.genres.append(genreEntity)
        }
        
        for platform in gameModel.platforms {
            let platformEntity = PlatformEntity()
            platformEntity.id = platform.id ?? 0
            platformEntity.name = platform.name ?? ""
            newGame.platforms.append(platformEntity)
        }

        for store in gameModel.stores {
            let storeEntity = StoreEntity()
            storeEntity.id = store.id ?? 0
            storeEntity.name = store.name ?? ""
            storeEntity.domain = store.domain ?? ""
            newGame.stores.append(storeEntity)
        }
        return newGame
//            id: gameModel.id,
//            name: gameModel.name,
//            backgroundImage: gameModel.backgroundImage,
//            r: gameModel.releasedDate,
//            rating: gameModel.rating,
//            desc: gameModel.description,
//            reviewsCount: gameModel.reviewsCount,
//            isFavorite: gameModel.isFavorite,
//            genres: gameModel.genres.map { genre in
//                return GenreModel(id: genre.id, name: genre.name)
//            },
//            platforms: gameModel.platforms.map { platforms in
//                return PlatformModel(id: platforms.id, name: platforms.name)
//            },
//            publishers: gameModel.publishers.map { publisher in
//                return PublisherModel(id: publisher.id, name: publisher.name)
//            },
//            stores: gameModel.stores.map { store in
//                return StoreModel(id: store.id, name: store.name, domain: store.domain)
//            }
//        )
    }
}
