//
//  RemoteDataSource.swift
//  Games CatalogueTests
//
//  Created by Fajar Septian on 05/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import XCTest
import Combine

@testable import Games_Catalogue

class RemoteDataSourceTest: XCTestCase {
    
    static var fakeResponse: GameResponse = GameResponse(id: 1,
                                                          name: "Football Manager 2021",
                                                          backgroundImage: "",
                                                          released: "2021-09-09",
                                                          rating: 4,
                                                          genres: [],
                                                          platforms: [],
                                                          description: "lorem ipsum",
                                                          reviewsCount: 34,
                                                          publishers: [],
                                                          stores: [])
    private var cancellables: Set<AnyCancellable>!
    private var testGameResponse: GameResponse!

    override func setUpWithError() throws {
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetGamesListRemoteDataSource() throws {
        // Given
        let dataSource = RemoteDataSourceMock()
        var test: [GameResponse] = []
        // When
        dataSource.getGames()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { games in
                test = games
            }).store(in: &cancellables)
        
        XCTAssert(dataSource.verify())
        XCTAssertEqual(test.count, 1)
        
    }
    
    func testGameDetailRemoteDataSource() throws {
        // Given
        let dataSource = RemoteDataSourceMock()
        
        // When
        dataSource.getDetailGame(gameId: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { game in
                self.testGameResponse = game
            }).store(in: &cancellables)
        
        XCTAssert(dataSource.verify())
        XCTAssertEqual(self.testGameResponse.name, "Football Manager 2021")
        
    }
}

extension RemoteDataSourceTest {
    
    class RemoteDataSourceMock: RemoteDataSourceProtocol {
        var functionWasCalled = false

        func getDetailGame(gameId: Int) -> AnyPublisher<GameResponse, Error> {
            functionWasCalled = true

            return Future<GameResponse, Error> { completion in
                completion(.success(
                    GameResponse(id: 1,
                                 name: "Football Manager 2021",
                                 backgroundImage: "",
                                 released: "2021-09-09",
                                 rating: 4,
                                 genres: [],
                                 platforms: [],
                                 description: "lorem ipsum",
                                 reviewsCount: 34,
                                 publishers: [],
                                 stores: [])
                ))
            }.eraseToAnyPublisher()
        }
        
        func getGames() -> AnyPublisher<[GameResponse], Error> {
            functionWasCalled = true
            return Future<[GameResponse], Error> { completion in
                completion(.success([fakeResponse]))
            }.eraseToAnyPublisher()
        }
        
        func verify() -> Bool {
            return functionWasCalled
        }
    }
    
}
