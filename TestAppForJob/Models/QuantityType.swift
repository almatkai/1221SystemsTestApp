//
//  QuantityType.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 24.08.2024.
//

import Foundation

enum QuantityType: String, CaseIterable {
    case countable = "Шт"
    case scalable = "Кг"
    
    var imageName: String {
        switch self {
        case .countable: return "piece"
        case .scalable: return "kg"
        }
    }
}

enum Quantity: CaseIterable {
    case countable(Int)
    case scalable(Double)
    
    static var allCases: [Quantity] {
        return [.countable(1), .scalable(0.1)]
    }
    
    var rawValue: String {
        switch self {
        case .countable(let count):
            return "\(count)"
        case .scalable(let weight):
            return "\(String(format: "%.1f", weight))"
        }
    }
}
