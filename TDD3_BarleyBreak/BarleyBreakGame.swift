//
//  BarleyBreakGame.swift
//  TDD3_BarleyBreak
//
//  Created by Илья Викторов on 16.04.2023.
//

import Foundation

class BarleyBreakGame {
    internal var items: [Int] = []
    internal let n: Int = 4
    internal var counter = 0
    
    var emptyItem: Int {
        n * n
    }
    
    @discardableResult
    func loadGame(items: [Int]) -> Bool {
        guard items.count == n*n else { return false }
        
        let alphabet = (1...n*n).map{Int($0)}
        
        for num in alphabet {
            if !items.contains(num) {
                return false
            }
        }
        
        self.items = items
        return true
    }
    
    func moveItem(value: Int) -> Bool {
        guard let index = items.firstIndex(where: {$0 == value}),
              let indexTail = items.firstIndex(where: {$0 == n*n}) else { return false }
        
        let dif = abs(index-indexTail)
        let isVerticalMatch = dif / n == 1 && dif.isMultiple(of: n)
        let isHorizontalMatch = dif == 1 && index / n == indexTail / n
        
        if isVerticalMatch || isHorizontalMatch {
            items.swapAt(index, indexTail)
            counter += 1
            return true
        }
        else {
            return false
        }
    }
}
