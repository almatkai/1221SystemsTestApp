//
//  ProductViewModel.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 23.08.2024.
//

import SwiftUI

let products: [ProductModel] = [
    .init(name: "Apple erg kjerhg jkherjg jerhgjk herjkg hjkrehgj ehrgjh ejer", description: "Fresh apple", price: 10.7, salePrice: 9.63, image: "1", quantityType: [.scalable, .countable], tag: .new, rating: 4.2, country: .fr),
    .init(name: "Banana", description: "Fresh banana", price: 300.7, salePrice: 240.56, image: "2", quantityType: [.scalable, .countable], tag: .udarPoCenam, rating: 2.4),
    .init(name: "Orange", description: "Fresh orange", price: 250.6, image: "3", quantityType: [.scalable], tag: .priceForCard, rating: 5, country: .usa),
    .init(name: "Milk", description: "Fresh milk", price: 1000.2, salePrice: 500.1, image: "4", quantityType: [.scalable], tag: .new, rating: 0.4),
    .init(name: "Bread", description: "Fresh bread", price: 999.9, image: "5", quantityType: [.countable], tag: .priceForCard, rating: 4, country: .it),
    .init(name: "Egg", description: "Fresh egg", price: 669.9, image: "6", quantityType: [.countable], rating: 3.2),
    .init(name: "Water", description: "Fresh water", price: 239.9, image: "7", quantityType: [.scalable], rating: 2.9),
    .init(name: "Potato", description: "Fresh potato", price: 344.4, image: "8", quantityType: [.scalable], rating: 4.3),
    .init(name: "Tomato", description: "Fresh tomato", price: 500, image: "9", quantityType: [.scalable], tag: .udarPoCenam, rating: 1.2),
    .init(name: "Cucumber", description: "Fresh cucumber", price: 400.9,  image: "10", quantityType: [.scalable], rating: 1.9),
    .init(name: "Carrot", description: "Fresh carrot", price: 300.1, image: "11", quantityType: [.scalable], rating: 4.5),
    .init(name: "Onion", description: "Fresh onion", price: 559.9, image: "12", quantityType: [.scalable], rating: 4.9),
]

class ViewModel: ObservableObject {
    @Published var size: CGSize = .zero
    @Published var productList: [CardItemModel]
    @Published var itemsInCart: [CardItemModel] = [] {
        didSet {
            calculateSubtotal()
        }
    }
    @Published var subtotal: Double = 0
    
    init() {
        self.productList = products.map {
            CardItemModel(
                product: $0,
                isFavorite: false,
                quantity: $0.quantityType[0] == .countable ? .countable(1) : .scalable(0.1),
                quantityType: $0.quantityType[0]
            )
        }
    }
    
    private func calculateSubtotal() {
        subtotal = itemsInCart.reduce(0) { $0 + $1.totalPrice }
    }
    
    @discardableResult
    func updateCart(for item: inout CardItemModel) -> Bool {
        if let index = itemsInCart.firstIndex(where: { $0.id == item.id }) {
            itemsInCart[index] = item
            
            if case .countable(let count) = item.quantity, count <= 0 {
                itemsInCart.remove(at: index)
                return false
            } else if case .scalable(let weight) = item.quantity, weight <= 0 {
                itemsInCart.remove(at: index)
                return false
            }
        } else {
            itemsInCart.append(item)
        }
        
        if let index = productList.firstIndex(where: { $0.id == item.id }) {
            productList[index] = item
        }
        
        return true
    }
        
    func removeFromCart(_ item: CardItemModel) {
        withAnimation {
            itemsInCart.removeAll { $0.id == item.id }
        }
        if let index = productList.firstIndex(where: { $0.id == item.id }) {
            withAnimation {
                productList[index].quantity = productList[index].quantityType == .countable ? .countable(1) : .scalable(0.1)
                productList[index].pressed = false
            }
        }
    }
}
