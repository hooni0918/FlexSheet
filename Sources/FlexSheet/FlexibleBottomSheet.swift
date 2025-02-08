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
    @State private var isDraggingHeader: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @State private var lastContentOffset: CGFloat = 0
    @State private var isExpanding: Bool = false
    
    public init(
        currentStyle: Binding<BottomSheetStyle>,
        style: FlexSheetStyle = .defaultFlex,
        @ViewBuilder content: () -> Content
    ) {
        self._currentStyle = currentStyle
        self.sheetStyle = style
        self.content = content()
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

       public var body: some View {
           GeometryReader { geometry in
               VStack(spacing: 0) {
                   Color.clear
                       .frame(height: 40)
                       .contentShape(Rectangle())
                       .gesture(
                           DragGesture()
                               .onChanged { value in
                                   isDraggingHeader = true
                                   let translation = value.translation.height
                                   draggedHeight = translation
                               }
                               .onEnded { value in
                                   isDraggingHeader = false
                                   let velocity = value.predictedEndTranslation.height - value.translation.height
                                   handleDragEnd(
                                       translation: value.translation.height,
                                       velocity: velocity,
                                       in: geometry
                                   )
                                   draggedHeight = 0
                               }
                       )
                   
                   ScrollViewReader { proxy in
                       ScrollView(showsIndicators: false) {
                           VStack(spacing: 0) {
                               GeometryReader { scrollGeometry in
                                   Color.clear.preference(
                                       key: ScrollOffsetPreferenceKey.self,
                                       value: scrollGeometry.frame(in: .named("scroll")).minY
                                   )
                               }
                               .frame(height: 0)
                               
                               content
                                   .frame(maxWidth: .infinity)
                           }
                       }
                       .coordinateSpace(name: "scroll")
                       .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                           if !isDraggingHeader {
                               handleScrollOffset(offset, in: geometry)
                           }
                       }
                       .disabled(isDraggingHeader)
                   }
               }
               .frame(maxHeight: .infinity)
               .background(Color(.systemBackground))
               .cornerRadius(FlexSheet.Constants.cornerRadius, corners: [.topLeft, .topRight])
               .offset(y: geometry.size.height - currentStyle.height(for: geometry.size.height) + draggedHeight)
               .gesture(
                   DragGesture()
                       .onChanged { value in
                           let translation = value.translation.height
                           draggedHeight = translation
                       }
                       .onEnded { value in
                           let velocity = value.predictedEndTranslation.height - value.translation.height
                           handleDragEnd(
                               translation: value.translation.height,
                               velocity: velocity,
                               in: geometry
                           )
                           draggedHeight = 0
                       }
               )
               .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentStyle)
               .animation(.spring(response: 0.3, dampingFraction: 0.7), value: draggedHeight)
           }
           .ignoresSafeArea()
       }
       
       private func handleScrollOffset(_ offset: CGFloat, in geometry: GeometryProxy) {
           let scrollDirection = offset - lastContentOffset
           
           if currentStyle == .half && scrollDirection < -20 && !isExpanding {
               isExpanding = true
               withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                   currentStyle = .full
               }
           }
           else if currentStyle == .full && offset > 20 {
               isExpanding = false
               withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                   currentStyle = .half
               }
           }
           
           lastContentOffset = offset
           scrollOffset = offset
       }
       
       private func handleDragEnd(translation: CGFloat, velocity: CGFloat, in geometry: GeometryProxy) {
           if abs(velocity) > sheetStyle.dragSensitivity {
               handleVelocityBasedSnap(velocity: velocity)
           } else {
               let screenHeight = geometry.size.height
               let currentOffset = screenHeight - currentStyle.height(for: geometry.size.height) + translation
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
