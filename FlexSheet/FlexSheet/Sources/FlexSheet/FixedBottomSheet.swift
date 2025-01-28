//
//  FixedBottomSheet.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//  Copyright © 2024 이지훈. All rights reserved.
//

import SwiftUI

public struct FixedBottomSheet<Content: View>: View {
    private let content: Content
    private let height: CGFloat
    
    public init(height: CGFloat, @ViewBuilder content: () -> Content) {
        self.height = height
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                handleBar
                
                content
                    .frame(maxWidth: .infinity)
            }
            .frame(height: height)
            .background(.white)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            .offset(y: geometry.size.height - height)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var handleBar: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray)
                .frame(width: 24, height: 2)
                .padding(.top, 10)
        }
        .frame(height: 40)
        .background(.white)
    }
} 