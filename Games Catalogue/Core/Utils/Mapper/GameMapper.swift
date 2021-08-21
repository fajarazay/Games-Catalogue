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
                description: result.description ?? "",

                genres: result.genres.map { genre in
                    return GenreModel(id: genre.id, name: genre.name)
                },
                platforms: result.platforms.map { platforms in
                    return PlatformModel(id: platforms.platform?.id, name: platforms.platform?.name)
                }
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
            newGame.desc = result.description ?? ""
            
            for responseGenre in result.genres {
                let genreEntity = GenreEntity()
                genreEntity.id = responseGenre.id ?? 0
                genreEntity.name = responseGenre.name ?? ""
                newGame.genres.append(genreEntity)
            }
            
            for responsePlatform in result.platforms {
                let platformEntity = PlatformEntity()
                platformEntity.id = responsePlatform.platform?.id ?? 0
                platformEntity.name = responsePlatform.platform?.name ?? ""
                newGame.platforms.append(platformEntity)
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
                genres: result.genres.map { genre in
                    return GenreModel(id: result.id, name: genre.name)
                },
                platforms: result.platforms.map { platforms in
                    return PlatformModel(id: platforms.id, name: platforms.name)
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
        
        for responseGenre in result.genres {
            let genreEntity = GenreEntity()
            genreEntity.id = responseGenre.id ?? 0
            genreEntity.name = responseGenre.name ?? ""
            newGame.genres.append(genreEntity)
        }
        
        for responsePlatform in result.platforms {
            let platformEntity = PlatformEntity()
            platformEntity.id = responsePlatform.platform?.id ?? 0
            platformEntity.name = responsePlatform.platform?.name ?? ""
            newGame.platforms.append(platformEntity)
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
            genres: gameEntity.genres.map { genre in
                return GenreModel(id: genre.id, name: genre.name)
            },
            platforms: gameEntity.platforms.map { platforms in
                return PlatformModel(id: platforms.id, name: platforms.name)
            }
        )
    }
    
}
