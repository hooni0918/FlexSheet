//
//  FlexSheetStyle.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/31/25.
//

import SwiftUI

@MainActor
public struct FlexSheetStyle {
    let animation: Animation
    let dragSensitivity: CGFloat
    let allowHide: Bool
    let sheetSize: BottomSheetStyle
    let fixedHeight: CGFloat
    let handleBarVisible: Bool
    
    public static let defaultFlex = FlexSheetStyle(
        animation: .spring(response: 0.3, dampingFraction: 0.7),
        dragSensitivity: 500,
        allowHide: false,
        sheetSize: .minimal,
        fixedHeight: 0,
        handleBarVisible: false
    )
    
    public static let interactiveFlex = FlexSheetStyle(
        animation: .spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8),
        dragSensitivity: 300,
        allowHide: true,
        sheetSize: .minimal,
        fixedHeight: 0,
        handleBarVisible: false
    )
    
    public static let defaultFixed = FlexSheetStyle(
        animation: .spring(response: 0.3, dampingFraction: 0.7),
        dragSensitivity: 500,
        allowHide: false,
        sheetSize: .notShow, 
        fixedHeight: UIScreen.main.bounds.height * 0.4,
        handleBarVisible: false
    )
    
    public init(
        animation: Animation = .spring(response: 0.3, dampingFraction: 0.7),
        dragSensitivity: CGFloat = 500,
        allowHide: Bool = false,
        sheetSize: BottomSheetStyle = .minimal,
        fixedHeight: CGFloat = 0,
        handleBarVisible: Bool = false
    ) {
        self.animation = animation
        self.dragSensitivity = dragSensitivity
        self.allowHide = allowHide
        self.sheetSize = sheetSize
        self.fixedHeight = fixedHeight
        self.handleBarVisible = handleBarVisible

    }
}
