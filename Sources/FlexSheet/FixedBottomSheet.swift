//
//  FixedBottomSheet.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//

import Foundation
import SwiftUI

public struct FixedBottomSheet<Content: View>: View {
    private let content: Content
    private let sheetStyle: FlexSheetStyle
    
    public init(
        style: FlexSheetStyle = .defaultFixed,
        @ViewBuilder content: () -> Content
    ) {
        self.sheetStyle = style
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if sheetStyle.handleBarVisible {
                    handleBar
                }
                content
                    .frame(maxWidth: .infinity)
            }
            .frame(height: sheetStyle.fixedHeight)
            .background(Color(.systemBackground))
            .cornerRadius(FlexSheet.Constants.cornerRadius, corners: [.topLeft, .topRight])
            .offset(y: geometry.size.height - sheetStyle.fixedHeight)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var handleBar: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(.systemGray3))
                .frame(width: 24, height: 2)
                .padding(.top, 10)
        }
        .frame(height: 40)
        .background(Color(.systemBackground))
    }
}
