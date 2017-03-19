//
//  Array+Patch.swift
//  SwiftPatch
//
//  Created by draveness on 16/03/2017.
//  Copyright © 2017 draveness. All rights reserved.
//

import Foundation

public extension Array {
    func take(_ count: Int) -> [Iterator.Element] {
        guard self.count >= count else { return Array(self) }
        return Array(self[0..<count])
    }

    mutating func clear() -> [Element] {
        self = []
        return self
    }
    
    func combination(_ num: Int) -> [[Element]] {
        guard num.isPositive && !self.isEmpty else { return [] }
        guard num <= self.length else { return [[]] }
        var bits = Array<Int>(Array<Int>(0..<num).reversed())
        
        func lastBit() -> Int? {
            for (index, bit) in bits.enumerated() {
                if bit + index < self.length - 1 {
                    bits[index] += 1
                    return bit
                }
            }
            return nil
        }
        
        var results: [[Element]] = []
        
        while true {
            var result: [Element] = []
            for index in bits.reversed() {
                result.append(self[index])
            }
            results.append(result)
            if lastBit() == nil {
                break
            }
        }
        return results
    }
    
    func cycle(_ times: Int = 1) -> [Element] {
        guard times > 0 else { return [] }
        return self * times
    }
    
//    func dig(_ idxs: Int...) -> Int {
//        return dig(idxs)
//    }
}

public extension Array where Element: Equatable {
    mutating func delete(_ obj: Element, all: Bool = true) -> Element? {
        var indexes: [Int] = []
        for (index, item) in self.enumerated() {
            if item == obj {
                indexes.append(index)
            }
        }
        
        guard indexes.count > 0 else { return nil }
        
        if !all {
            indexes = [indexes.first!]
        }
        
        for index in indexes.reversed() {
            self.remove(at: index)
        }
        
        return obj
    }
    
    func isEqual(_ other: [Element]) -> Bool {
        guard self.length == other.length else { return false }
        var lhs = self
        var rhs = other
        
        for l in lhs {
            if rhs.contains(l) {
                _ = rhs.delete(l, all: false)
                _ = lhs.delete(l, all: false)
            } else {
                return false
            }
        }
        return true
    }
}

public func &<T: Equatable>(left: Array<T>, right: Array<T>) -> Array<T> {
    let lhs = left
    var rhs = right
    
    var result: [T] = []
    for l in lhs {
        for (index, r) in rhs.enumerated() {
            if l == r {
                result.append(l)
                rhs.remove(at: index)
                break
            }
        }
        
    }
    return result
}

public func *<T>(left: Array<T>, right: Int) -> Array<T> {
    var result: [T] = []
    for _ in 1...right {
        result += left
    }
    return result
}

public func *<T>(left: Array<T>, right: String) -> String {
    return left.map { "\($0)" }.joined(separator: right)
}

public func -<T: Equatable>(left: Array<T>, right: Array<T>) -> Array<T> {
    var lhs = left
    let rhs = right
    
    for (index, l) in lhs.enumerated() {
        for r in rhs {
            if l == r {
                lhs.remove(at: index)
            }
        }
        
    }
    return lhs
}