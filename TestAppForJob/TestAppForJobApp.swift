//
//  TestAppForJobApp.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 22.08.2024.
//

import SwiftUI

@main
struct TestAppForJobApp: App {
    @StateObject var viewModel = ViewModel()
    @State var screenSize: CGSize = .zero
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                viewModel.size = proxy.size
                            }
                    }
                }
                .environmentObject(viewModel)
        }
    }
}
