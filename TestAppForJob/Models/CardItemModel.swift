//
//  CardItemModel.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 23.08.2024.
//

import Foundation

struct CardItemModel: Identifiable {
    var id = UUID()
    var product: ProductModel
    var isFavorite: Bool
    var pressed = false
    var quantity: Quantity
    var quantityType: QuantityType {
        didSet {
            quantity = quantityType == .countable ? .countable(1) : .scalable(0.1)
        }
    }
    
    var totalPrice: Double {
        switch quantity {
        case .countable(let count):
            return product.price * Double(count)
        case .scalable(let weight):
            return product.price * weight
        }
    }
}
