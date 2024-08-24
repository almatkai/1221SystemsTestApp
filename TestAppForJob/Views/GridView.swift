//
//  GridView.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 22.08.2024.
//

import SwiftUI

struct GridView: View, ProductCellViewProtocol {
    
    @EnvironmentObject var viewModel: ViewModel
    @Binding var productList: [CardItemModel]
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 168))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach($productList) { $item in
                VStack(spacing: 0){
                    CardTop(of: $item)
                    CardBottom(of: $item)
                        .frame(height: 110)
                }
                .frame(width: 168, height: 278)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                .shadow(color: Color(hex: "#8B8B8B").opacity(0.2),radius: 5)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func CardTop(of item: Binding<CardItemModel>) -> some View {
        ZStack {
            Image(item.product.image.wrappedValue)
                .resizable()
                .scaledToFit()
            VStack {
                HStack {
                    VStack {
                        Tag(tag: item.product.tag.wrappedValue)
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        SavingDoc(item: item)
                        Spacer()
                    }
                }
                Spacer()
                
                HStack {
                    Rating(rating: item.product.rating.wrappedValue)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private func CardBottom(of item: Binding<CardItemModel>) -> some View {
        VStack () {
            ProductName(item.product.name.wrappedValue)
            
            if item.pressed.wrappedValue, item.product.quantityType.count != 1 {
                Picker("QuantityType", selection: item.quantityType) {
                    ForEach(QuantityType.allCases, id: \.self) { quantityType in
                        Text(quantityType.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 158, height: 28)
            } else if item.product.country.wrappedValue != .rus {
                CountryName(item.product.country.wrappedValue)
            }
            
            Spacer()
            
            HStack {
                if !item.pressed.wrappedValue {
                    PriceTag(of: item.wrappedValue)
                        .frame(width: item.pressed.wrappedValue ? 0 : nil)
                }
                ShopButton(item: item)
            }
        }
        .padding(.leading, 8)
        .padding(.top, 8)
        .padding(.bottom, 4)
        .padding(.trailing, 4)
    }
}

#Preview {
    ContentView()
}
