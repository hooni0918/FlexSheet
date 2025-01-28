//
//  FlexibleBottomSheet.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//  Copyright © 2024 이지훈. All rights reserved.
//

import SwiftUI

public struct FlexibleBottomSheet<Content: View>: View {
    private let content: Content
    @Binding private var currentStyle: BottomSheetStyle
    @State private var offset: CGFloat = 0
    @GestureState private var isDragging: Bool = false
    @State private var isScrollEnabled: Bool = false
    
    public init(currentStyle: Binding<BottomSheetStyle>, @ViewBuilder content: () -> Content) {
        self._currentStyle = currentStyle
        self.content = content()
    }
    
    private func getClosestSnapPoint(to offset: CGFloat) -> BottomSheetStyle {
        let screenHeight = UIScreen.main.bounds.height
        let currentHeight = screenHeight - offset
        
        let distances = [
            (abs(currentHeight - BottomSheetStyle.minimal.height), BottomSheetStyle.minimal),
            (abs(currentHeight - BottomSheetStyle.half.height), BottomSheetStyle.half),
            (abs(currentHeight - BottomSheetStyle.full.height), BottomSheetStyle.full)
        ]
        
        return distances.min(by: { $0.0 < $1.0 })?.1 ?? .minimal
    }
    
    public var body: some View {
        GeometryReader { _ in
            VStack(spacing: 0) {
                handleBar
                
                ScrollView(showsIndicators: false) {
                    content
                }
                .disabled(!isScrollEnabled)
            }
            .frame(maxHeight: .infinity)
            .background(.white)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            .offset(y: UIScreen.main.bounds.height - currentStyle.height + offset)
            .gesture(dragGesture)
        }
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
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                let translation = value.translation.height
                offset = (currentStyle == .full && translation < 0) ? 0 : translation
            }
            .onEnded { value in
                let translation = value.translation.height
                let velocity = value.predictedEndTranslation.height - translation
                
                handleDragEnd(translation: translation, velocity: velocity)
            }
    }
    
    private func handleDragEnd(translation: CGFloat, velocity: CGFloat) {
        if abs(velocity) > 500 {
            handleVelocityBasedSnap(velocity: velocity)
        } else {
            let screenHeight = UIScreen.main.bounds.height
            let currentOffset = screenHeight - currentStyle.height + translation
            currentStyle = getClosestSnapPoint(to: currentOffset)
        }
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            offset = 0
            isScrollEnabled = (currentStyle == .full)
        }
    }
    
    private func handleVelocityBasedSnap(velocity: CGFloat) {
        if velocity > 0 {
            switch currentStyle {
            case .full:
                currentStyle = .half
            case .half:
                currentStyle = .minimal
            case .minimal: break
            }
        } else {
            switch currentStyle {
            case .full: break
            case .half:
                currentStyle = .full
            case .minimal:
                currentStyle = .half
            }
        }
    }
} 