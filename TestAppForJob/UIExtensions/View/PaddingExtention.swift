//
//  PaddingExtention.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 24.08.2024.
//

import SwiftUI

extension View {
    public func padding(_ length: CGFloat = 16, _ edges: [Edge.Set]) -> some View {
        self.padding(EdgeInsets(
            top: edges.contains(.top) ? length : 0,
            leading: edges.contains(.leading) ? length : 0,
            bottom: edges.contains(.bottom) ? length : 0,
            trailing: edges.contains(.trailing) ? length : 0))
    }
}
