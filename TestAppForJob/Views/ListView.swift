//
//  ListView.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 22.08.2024.
//

import SwiftUI

struct ListView: View, ProductCellViewProtocol {
    
    @EnvironmentObject var viewModel: ViewModel
    @Binding var productList: [CardItemModel]
    
    var body: some View {
        Divider()
        ForEach($productList) { $item in
            HStack {
                CardLeft(of: $item)
                    .frame(width: 144)
                CardRight(of: $item)
            }
            .padding(16, [.leading, .top, .bottom])
            .padding(8 , [.trailing])
            .frame(height: 176)
            Divider().foregroundStyle(Color(hex: "#D7D7D7")).frame(height: 1)
        }
    }
    
    @ViewBuilder
    private func CardLeft(of item: Binding<CardItemModel>) -> some View {
        ZStack {
            Image(item.product.image.wrappedValue)
                .resizable()
                .scaledToFit()
            VStack {
                HStack {
                    Tag(tag: item.product.tag.wrappedValue)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func CardRight(of item: Binding<CardItemModel>) -> some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    HStack (spacing: 4) {
                        Rating(rating: item.product.rating.wrappedValue)
                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundStyle(Color(hex: "#262626").opacity(0.6))
                        Text("19 отзывов")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "#262626").opacity(0.6))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                
                HStack {
                    ProductName(item.product.name.wrappedValue)
                        .frame(width: geometry.size.width - 32) // 32 - width of SavingDoc
                    Spacer()
                }
                
                
                if item.pressed.wrappedValue, item.product.quantityType.count != 1 {
                    Spacer()
                    Picker("QuantityType", selection: item.quantityType) {
                        ForEach(QuantityType.allCases, id: \.self) { quantityType in
                            Text(quantityType.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(height: 28)
                } else if item.product.country.wrappedValue != .rus {
                    CountryName(item.product.country.wrappedValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                } else {
                    Spacer()
                }
                
                ShopButton(item: item).frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(4)
            }
            .overlay {
                SavingDoc(item: item).frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(maxHeight: .infinity, alignment: .topTrailing)
            }
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
