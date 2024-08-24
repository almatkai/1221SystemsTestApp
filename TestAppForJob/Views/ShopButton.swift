//
//  ShopButton.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 23.08.2024.
//

import SwiftUI

struct ShopButton: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var item: CardItemModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .modifier(ShopButtonModifier(pressed: $item.pressed))
            .foregroundStyle(Color(hex: "#15B742"))
            .overlay {
                if item.pressed {
                    HStack {
                        Button(action: {
                            decreaseQuantity()
                        }) {
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        VStack {
                            Text("\(item.quantity.rawValue)")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            Text("~\(item.totalPrice, specifier: "%.2f")₽")
                                .font(.system(size: 12))
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        Spacer()
                        Button(action: {
                            increaseQuantity()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 8)
                } else {
                    Image("shop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.white)
                }
            }
            .onTapGesture {
                withAnimation {
                    item.pressed = true
                    viewModel.updateCart(for: &item)
                }
            }
    }
    
    private func decreaseQuantity() {
        switch item.quantity {
        case .countable(let count):
            if count > 1 {
                item.quantity = .countable(count - 1)
                if !viewModel.updateCart(for: &item) {
                    withAnimation{
                        item.pressed = false
                    }
                }
            } else {
                withAnimation{
                    item.pressed = false
                    item.quantity = .countable(1)
                    viewModel.removeFromCart(item)
                }
            }
        case .scalable(let weight):
            if weight > 0.1 {
                item.quantity = .scalable((weight - 0.1).rounded(to: 1))
                if !viewModel.updateCart(for: &item) {
                    withAnimation{
                        item.pressed = false
                    }
                }
            } else {
                withAnimation{
                    item.pressed = false
                    item.quantity = .scalable(0.1)
                    viewModel.removeFromCart(item)
                }
            }
        }
    }
    
    private func increaseQuantity() {
        switch item.quantity {
        case .countable(let count):
            withAnimation{
                item.quantity = .countable(count + 1)
            }
        case .scalable(let weight):
            withAnimation{
                item.quantity = .scalable(weight + 0.1)
            }
        }
        viewModel.updateCart(for: &item)
    }
    
    /// Shop Button not/Pressed Modifier
    struct ShopButtonModifier: ViewModifier {
        @Binding var pressed: Bool
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity)
                .frame(width: pressed ? nil : 48, height: 36)
        }
    }
}

extension Double {
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

#Preview {
    ContentView()
}
