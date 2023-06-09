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
    
    //тест на загрузку поля с не уникальными элементами
    func testLoadingGameWithNonUniqueOrderAndWrongAlphabet() {
        guard let game else { return }
        
        let items = [1, 1, 1, 1,
                     2, 2, 2, 2,
                     3, 3, 3, 3,
                     4, 4, 4, 4]
        
        let result = game.loadGame(items: items)
        let estimated = false

        XCTAssertEqual(result, estimated)
    }
    
    //тест на передвижение пустой клетки при выборе ближайшего элемента
    func testShouldMoveItemWhenItemNearby() {
        guard let game else { return }
        
        let items = [
            1, 2, 3, 4,
            10, 9, 13, 11,
            14, 6, 5, 8,
            16, 7, 12, 15
        ]
        
        game.loadGame(items: items)
        
        let result = game.moveItem(value: 14)
        let estimated = true
        
        XCTAssertEqual(result, estimated)
    }
    
    //тест когда выбранный элемент находится рядом (1 клетка), но по диагонали
    func testNotShouldMoveItemWhenItemOnDiagonal() {
        guard let game else { return }
        
        let items = [
            1, 2, 3, 4,
            10, 9, 13, 11,
            14, 6, 5, 8,
            16, 7, 12, 15
        ]
        
        game.loadGame(items: items)
        
        let result = game.moveItem(value: 6)
        let estimated = false
        
        XCTAssertEqual(result, estimated)
    }
    
    //тест когда выбранный элемент находится дальше 1 клетки
    func testNotShouldMoveItemWhenItemOnFar() {
        guard let game else { return }
        
        let items = [
            1, 2, 3, 4,
            10, 9, 13, 11,
            14, 6, 5, 8,
            16, 7, 12, 15
        ]
        
        game.loadGame(items: items)
        
        let result = game.moveItem(value: 4)
        let estimated = false
        
        XCTAssertEqual(result, estimated)
    }
   
    //проверка на обнаружение выигрышной комбинации
    func testCheckVictoryCombination() {
        guard let game else { return }
        
        let items = [
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 16, 15
        ]
        
        game.loadGame(items: items)
        game.moveItem(value: 15)
        
        let result = game.checkFoVictory()
        let estimated = true
        
        XCTAssertEqual(result, estimated)
    }
    
    //проврка на решаемость последовательности
    func testIsSolvedGame() {
        guard let game else { return }
        
        let items = [
            16, 15, 14, 13,
            12, 11, 10, 9,
            8, 7, 6, 5,
            4, 3, 2, 1
        ]
        
        game.loadGame(items: items)
        
        let result = game.isSolvedGame()
        let estimated = true
        
        XCTAssertEqual(result, estimated)
    }
    
    //проврка на решаемую последовательность
    func testIsNotSolvedGame() {
        guard let game else { return }
        
        let items = [
            15, 14, 13, 12,
            11, 10, 9, 8,
            7, 6, 5, 4,
            3, 2, 1, 16
        ]
        
        game.loadGame(items: items)
        
        let result = game.isSolvedGame()
        let estimated = false
        
        XCTAssertEqual(result, estimated)
    }
    
    func testChangeCounter() {
        guard let game else { return }
        
        let items = [
            16, 15, 14, 13,
            12, 11, 10, 9,
            8, 7, 6, 5,
            4, 3, 2, 1
        ]
        
        game.loadGame(items: items)
        
        game.moveItem(value: 15)
        game.moveItem(value: 14)
        game.moveItem(value: 15)
        game.moveItem(value: 1)
        
        let result = game.counter
        let estimated = 2
        
        XCTAssertEqual(result, estimated)
    }
    
    func testAfterWinNotClearCounter() {
        guard let game else { return }
        
        let items = [
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 16, 15
        ]
        
        game.loadGame(items: items)
        
        game.moveItem(value: 15)
        let _ = game.checkFoVictory()
        
        let result = game.counter
        let estimated = 1
        
        XCTAssertEqual(result, estimated)
    }
    
    func testMoveSelfItem() {
        guard let game else { return }
        
        let items = [
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 16, 15
        ]
        
        game.loadGame(items: items)
        game.moveItem(value: 16)
        
        let result = game.items
        let estimated = items
        
        XCTAssertEqual(result, estimated)
    }
}
