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
    
    public init(
        currentStyle: Binding<BottomSheetStyle>,
        style: FlexSheetStyle = .defaultFlex,
        @ViewBuilder content: () -> Content
    ) {
        self._currentStyle = currentStyle
        self.sheetStyle = style
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Color.clear
                    .frame(height: 40)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                let translation = value.translation.height
                                draggedHeight = translation
                            }
                            .onEnded { value in
                                isDragging = false
                                let velocity = value.predictedEndTranslation.height - value.translation.height
                                handleDragEnd(
                                    translation: value.translation.height,
                                    velocity: velocity,
                                    in: geometry
                                )
                                draggedHeight = 0
                            }
                    )
                
                content
                    .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(FlexSheet.Constants.cornerRadius, corners: [.topLeft, .topRight])
            .offset(y: geometry.size.height - currentStyle.height(for: geometry.size.height) + draggedHeight)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentStyle)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: draggedHeight)
        }
        .ignoresSafeArea()
    }
    
    private func getClosestSnapPoint(to offset: CGFloat, in geometry: GeometryProxy) -> BottomSheetStyle {
        let screenHeight = geometry.size.height
        let currentHeight = screenHeight - offset
        
        let distances = [
            (abs(currentHeight - BottomSheetStyle.minimal.height(for: screenHeight)), BottomSheetStyle.minimal),
            (abs(currentHeight - BottomSheetStyle.half.height(for: screenHeight)), BottomSheetStyle.half),
            (abs(currentHeight - BottomSheetStyle.full.height(for: screenHeight)), BottomSheetStyle.full)
        ]
        
        return distances.min(by: { $0.0 < $1.0 })?.1 ?? .half
    }
    
    private func handleDragEnd(translation: CGFloat, velocity: CGFloat, in geometry: GeometryProxy) {
        if abs(velocity) > sheetStyle.dragSensitivity {
            handleVelocityBasedSnap(velocity: velocity)
        } else {
            let screenHeight = geometry.size.height
            let currentOffset = screenHeight - currentStyle.height(for: screenHeight) + translation
            currentStyle = getClosestSnapPoint(to: currentOffset, in: geometry)
        }
    }
    
    private func handleVelocityBasedSnap(velocity: CGFloat) {
        if velocity > 0 {
            switch currentStyle {
            case .full:
                currentStyle = .half
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
            case .full:
                break
            }
        }
    }
}

@MainActor
private struct ScrollOffsetPreferenceKey: @preconcurrency PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
