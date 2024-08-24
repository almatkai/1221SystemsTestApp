//
//  ProductModel.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 22.08.2024.
//

import Foundation
import SwiftUI

struct ProductModel: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var price: Double
    private(set) var isOnSale = false
    var salePrice: Double?
    var salePercentage: Double?
    var image: String
    var quantityType: [QuantityType]
    var tag: Tag?
    var rating: Double
    var country: Country
    
    init(id: UUID = UUID(), name: String, description: String, price: Double, salePrice: Double? = nil, salePercentage: Double? = nil, image: String, quantityType: [QuantityType], tag: Tag? = nil, rating: Double, country: Country = .rus) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.salePrice = salePrice
        self.salePercentage = salePercentage
        self.image = image
        self.quantityType = quantityType
        self.tag = tag
        self.rating = rating
        self.country = country
        
        if salePrice != nil {
            isOnSale = true
            setPercentage()
        } else {
            isOnSale = false
        }
    }
    
    enum Tag: String {
        case udarPoCenam = "Удар по ценам"
        case new = "Новинка"
        case priceForCard = "Цена по карте"
        
        var color: Color {
            switch self {
            case .udarPoCenam:
                return Color(hex: "#FC6A6F").opacity(0.9)
            case .new:
                return Color(hex: "#7A79BA").opacity(0.9)
            case .priceForCard:
                return Color(hex: "#5BCD7B").opacity(0.9)
            }
        }
    }
    
    var currentPrice: Double {
        return isOnSale ? (salePrice ?? price) : price
    }
    
    mutating func applyDiscount(percentage: Double) {
        isOnSale = true
        salePercentage = percentage
        salePrice = price * (1 - percentage / 100)
    }
    
    mutating func applyFixedSalePrice(_ newPrice: Double) {
        isOnSale = true
        salePrice = newPrice
        salePercentage = ((price - newPrice) / price) * 100
    }
    
    mutating func setPercentage() {
        salePercentage = ((price - salePrice!) / price) * 100
    }
}
