//
//  Row.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation

struct Row<T>: Identifiable {
    let id = UUID()
    let items: [T]
    let column: Int
    var isFitting: Bool { items.count == column }
    var emptyColumnCount: Int { column - items.count }
    
    static func build(forColumn column: Int, values: [T], maxLength: Int? = nil) -> [Row<T>] {
        var values = values
        if let maxLength = maxLength {
            values = Array(values.prefix(maxLength))
        }
        let groupedItem = try? values.grouped(size: column)
        return groupedItem?.map { Row(items: $0, column: column) } ?? []
    }
}

private extension Array {
    enum GroupedError: Error, Equatable {
        case invalidArgument
        case emptyItems
    }
    
    func grouped(size: Int) throws -> [[Element]] {
        if size == 0 {
            throw GroupedError.invalidArgument
        }
        
        if self.isEmpty {
            throw GroupedError.emptyItems
        }
        
        var buffer = self
        var result = [[Element]]()
        
        while buffer.count != 0 {
            var chunk = [Element]()
            for _ in (0..<size) where buffer.count != 0 {
                chunk.append(buffer.remove(at: 0))
            }
            result.append(chunk)
            chunk = []
        }
        
        return result
    }
}
