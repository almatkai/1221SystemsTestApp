//
//  ProductCellViewProtocol.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 23.08.2024.
//

import SwiftUI

protocol ProductCellViewProtocol {}

extension ProductCellViewProtocol {
    func Tag(tag: ProductModel.Tag?) -> some View {
        Group {
            if let tag = tag {
                VStack {
                    Text(tag.rawValue)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.leading, 12)
                        .padding(.trailing, 6)
                        .padding(.top, 2)
                        .padding(.bottom, 4)
                }
                .background(tag.color)
                .cornerRadius(10, corners: [.topRight, .bottomRight, .topLeft])
            } else {
                EmptyView()
            }
        }
    }
    
    func SavingDoc(item: Binding<CardItemModel>) -> some View {
        VStack {
            Button(action: {
                
            }){
                Image("bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
            }
            .padding(8)
            Button(action: {
                item.isFavorite.wrappedValue.toggle()
            }){
                Image(item.isFavorite.wrappedValue ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
            }
            .padding(8)
        }
        .frame(width: 32, height: 64)
        .background(.white.opacity(0.8))
        .cornerRadius(16, corners: .bottomLeft)
    }
    
    func Rating(rating: Double) -> some View {
        HStack {
            Image("star")
                .resizable()
                .scaledToFit()
                .frame(width: 12)
            
            Text("\(rating, specifier: "%.1f")")
                .opacity(0.8)
        }
        .padding(4)
    }
    
    func ProductName(_ name: String) -> some View {
        Text(name)
            .font(.system(size: 12))
            .foregroundStyle(Color(hex: "#262626").opacity(0.8))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func CountryName(_ country: Country) -> some View {
        Text("\(country.rawValue) \(country.flag)")
            .font(.system(size: 12))
            .foregroundStyle(Color(hex: "#262626").opacity(0.8))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func PriceTag(of item: CardItemModel) -> some View {
        
        let cents = item.product.price - Double(Int(item.product.price))
        
        return VStack {
            if item.product.isOnSale, let salePrice = item.product.salePrice {
                VStack (spacing: 0){
                    OverallPriceTag(price: salePrice)
                    OldPrice(price: item.product.currentPrice)
                }
            } else {
                OverallPriceTag(price: item.product.currentPrice)
            }
        }
        
        @ViewBuilder
        func OverallPriceTag(price: Double) -> some View {
            HStack (spacing: 2) {
                VStack {
                    Text("\(Int(price))")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color(hex: "#262626"))
                    Spacer()
                }
                VStack {
                    Text("\(Int(cents * 100))")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color(hex: "#262626"))
                    Spacer()
                }
                VStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 1.4, height: 17)
                        .foregroundStyle(Color(hex: "#262626"))
                        .rotationEffect(.degrees(45))
                    
                }
                .frame(width: 20, height: 20)
                .overlay {
                    VStack {
                        HStack {
                            Image("rub")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 7.24)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(item.product.quantityType[0].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 9.97)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }.frame(height: 22)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        @ViewBuilder
        func OldPrice(price: Double) -> some View {
            Text("\(price, specifier: "%.1f")")
                .font(.system(size: 12))
                .foregroundStyle(Color(hex: "#262626").opacity(0.6))
                .overlay {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .foregroundStyle(Color(hex: "#262626").opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 14)
        }
    }
}

#Preview {
    ContentView()
}
