//
//  CartView.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 25.08.2024.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if viewModel.itemsInCart.isEmpty {
                        Text("Корзина пуста")
                            .font(.system(size: 24))
                            .foregroundStyle(Color(hex: "#262626"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 100)
                    } else {
                        ListView(productList: $viewModel.itemsInCart)
                    }
                }
            }
            .navigationBarTitle("Корзина")
        }
    }
}
