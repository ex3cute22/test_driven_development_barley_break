//
//  TDD3_BarleyBreakTests.swift
//  TDD3_BarleyBreakTests
//
//  Created by Илья Викторов on 16.04.2023.
//

import XCTest
@testable import TDD3_BarleyBreak

final class TDD3_BarleyBreakTests: XCTestCase {
    var game: BarleyBreakGame?
    
    override func setUpWithError() throws {
        game = BarleyBreakGame()
    }

    override func tearDownWithError() throws {
        game = nil
    }
    
    //тест на загрузку игру
    func testShouldLoadingGame() {
        guard let game else { return }
        
        let items = [1, 2, 3, 4,
                     5, 6, 7, 8,
                     9, 10, 11, 12,
                     13, 14, 15, 16]
        
        
        
        let result = game.loadGame(items: items)
        let estimated = true
        
        XCTAssertEqual(result, estimated)
    }
    
    //тест на загрузку поля с порядком отличным у самой игры
    func testLoadingGameWithNotEqualsN() {
        guard let game else { return }
        
        let items = [1, 2, 3,
                     4, 5, 6,
                     7, 8, 9]
        
        let result = game.loadGame(items: items)
        let estimated = false

        XCTAssertEqual(result, estimated)
    }
}
