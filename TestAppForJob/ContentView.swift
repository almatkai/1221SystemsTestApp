//
//  ContentView.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 22.08.2024.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: ViewModel
    @State var grid = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if grid {
                        GridView(productList: $viewModel.productList)
                    } else {
                        ListView(productList: $viewModel.productList)
                    }
                }
            }
            .onAppear {
                applySales()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            grid.toggle()
                        }
                    }, label: {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(hex: "#F1F1F1"))
                            .overlay {
                                Image(grid ? "grid" : "list")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(Color(hex: "#15B742"))
                            }
                    })
                    .padding(.bottom, 6)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(hex: "#F1F1F1"))
                            .overlay {
                                Image("shop")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color(hex: "#15B742"))
                            }
                    }
                    .padding(.bottom, 6)
                }
            }
        }
    }
    
    private func applySales() {
        viewModel.productList[0].product.applyDiscount(percentage: 10)
        viewModel.productList[1].product.applyFixedSalePrice(200)
        viewModel.productList[3].product.applyDiscount(percentage: 20)
    }
}

//#Preview {
//    ContentView()
//}
