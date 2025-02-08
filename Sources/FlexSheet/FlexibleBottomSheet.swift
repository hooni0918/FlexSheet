//
//  FlexibleBottomSheet.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//

import SwiftUI

public struct FlexibleBottomSheet<Content: View>: View {
    private let content: Content
    private let sheetStyle: FlexSheetStyle
    @Binding private var currentStyle: BottomSheetStyle
    @State private var draggedHeight: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var isScrollEnabled: Bool = false
    
    public init(
        currentStyle: Binding<BottomSheetStyle>,
        style: FlexSheetStyle = .defaultFlex,
        @ViewBuilder content: () -> Content
    ) {
        self._currentStyle = currentStyle
        self.sheetStyle = style
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
    
    private var dragGesture: some Gesture {
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
                
                if abs(velocity) > sheetStyle.dragSensitivity {
                    if velocity > 0 {
                        switch currentStyle {
                        case .full:
                            currentStyle = .half
                            isScrollEnabled = false
                        case .half:
                            currentStyle = .minimal
                        case .minimal:
                            if sheetStyle.allowHide {
                                currentStyle = .notShow
                            }
                        case .notShow:
                            break
                        }
                    } else {
                        switch currentStyle {
                        case .notShow:
                            currentStyle = .minimal
                        case .minimal:
                            currentStyle = .half
                        case .half:
                            currentStyle = .full
                            isScrollEnabled = true
                        case .full:
                            break
                        }
                    }
                } else {
                    let screenHeight = UIScreen.main.bounds.height
                    let currentOffset = screenHeight - currentStyle.height(for: screenHeight) + translation
                    let newStyle = getClosestSnapPoint(to: currentOffset)
                    currentStyle = newStyle
                    isScrollEnabled = (newStyle == .full)
                }
                
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    draggedHeight = 0
                }
            }
    }
    
    @ViewBuilder
    private var handleBar: some View {
        if sheetStyle.handleBarVisible {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(.systemGray3))
                    .frame(width: FlexSheet.Constants.handleBarWidth, height: FlexSheet.Constants.handleBarThickness)
                    .padding(.top, 10)
            }
            .frame(height: FlexSheet.Constants.handleBarHeight)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .gesture(dragGesture)
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                handleBar
                
                content
                    .disabled(!isScrollEnabled)
            }
            .frame(maxHeight: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(FlexSheet.Constants.cornerRadius, corners: [.topLeft, .topRight])
            .offset(y: geometry.size.height - currentStyle.height(for: geometry.size.height) + draggedHeight)
            .animation(sheetStyle.animation, value: currentStyle)
            .onChange(of: currentStyle) { _, newStyle in
                isScrollEnabled = (newStyle == .full)
            }
        }
        .ignoresSafeArea()
    }
}
