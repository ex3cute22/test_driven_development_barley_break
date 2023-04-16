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
    
    @discardableResult
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
    
    func checkFoVictory() -> Bool {
        for (i,elem) in items.enumerated() {
            if i+1 != elem {
                return false
            }
        }
        
        return true
    }
    
    func isSolvedGame() -> Bool {
        var sum = 0
        for i in 0..<n*n {
            let currentItem = items[i]
            if currentItem != n*n {
                for j in i..<n*n {
                    if items[j] < currentItem {
                        sum += 1
                    }
                }
            } else {
                sum += i / 4 + 1
            }
        }
        return sum.isMultiple(of: 2)
    }
}
