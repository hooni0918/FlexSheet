//
//  FlexibleBottomSheet.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//

import SwiftUI

public struct FlexibleBottomSheet<Content: View>: View {
    private let content: Content
    @Binding private var currentStyle: BottomSheetStyle
    @State private var draggedHeight: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @State private var lastContentOffset: CGFloat = 0
    @State private var isScrollEnabled: Bool = false
    
    public init(
        currentStyle: Binding<BottomSheetStyle>,
        @ViewBuilder content: () -> Content
    ) {
        self._currentStyle = currentStyle
        self.content = content()
    }
    
    private func getClosestSnapPoint(to offset: CGFloat) -> BottomSheetStyle {
        let screenHeight = UIScreen.main.bounds.height
        let currentHeight = screenHeight - offset
        
        let distances = [
            (abs(currentHeight - BottomSheetStyle.minimal.height(for: screenHeight)), BottomSheetStyle.minimal),
            (abs(currentHeight - BottomSheetStyle.half.height(for: screenHeight)), BottomSheetStyle.half),
            (abs(currentHeight - BottomSheetStyle.full.height(for: screenHeight)), BottomSheetStyle.full)
        ]
        
        return distances.min(by: { $0.0 < $1.0 })?.1 ?? .minimal
    }
    
    public var body: some View {
        GeometryReader { geometry in
            if #available(iOS 17.0, *) {
                VStack(spacing: 0) {
                    content
                }
                .frame(maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10, corners: [.topLeft, .topRight])
                .offset(y: geometry.size.height - currentStyle.height(for: geometry.size.height) + draggedHeight)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            let translation = value.translation.height
                            if currentStyle == .full && translation < 0 {
                                draggedHeight = 0
                            } else {
                                draggedHeight = translation
                            }
                        }
                        .onEnded { value in
                            isDragging = false
                            let translation = value.translation.height
                            let velocity = value.predictedEndTranslation.height - translation
                            
                            if abs(velocity) > 500 {
                                if velocity > 0 {
                                    switch currentStyle {
                                    case .full:
                                        currentStyle = .half
                                        isScrollEnabled = false
                                    case .half:
                                        currentStyle = .minimal
                                    case .minimal, .notShow:
                                        break
                                    }
                                } else {
                                    switch currentStyle {
                                    case .full:
                                        break
                                    case .half:
                                        currentStyle = .full
                                        isScrollEnabled = true
                                    case .minimal:
                                        currentStyle = .half
                                    case .notShow:
                                        currentStyle = .minimal
                                    }
                                }
                            } else {
                                let screenHeight = geometry.size.height
                                let currentOffset = screenHeight - currentStyle.height(for: screenHeight) + translation
                                let newStyle = getClosestSnapPoint(to: currentOffset)
                                currentStyle = newStyle
                                isScrollEnabled = (newStyle == .full)
                            }
                            
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                draggedHeight = 0
                            }
                        }
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentStyle)
                .onChange(of: currentStyle) { _, newStyle in
                    isScrollEnabled = (newStyle == .full)
                }
            } else {
            }
        }
        .ignoresSafeArea()
    }
}

@MainActor
private struct ScrollOffsetPreferenceKey: @preconcurrency PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
