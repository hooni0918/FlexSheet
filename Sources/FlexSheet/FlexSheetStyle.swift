//
//  FlexSheetStyle.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/31/25.
//

import SwiftUI

public struct FlexSheetStyle : Sendable {
    let animation: Animation
    let dragSensitivity: CGFloat
    let allowHide: Bool
    
    public static let `default` = FlexSheetStyle(
        animation: .spring(response: 0.3, dampingFraction: 0.7),
        dragSensitivity: 500,
        allowHide: false
    )
    
    public static let interactive = FlexSheetStyle(
        animation: .spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8),
        dragSensitivity: 300,
        allowHide: true
    )
    
    public init(
        animation: Animation = .spring(response: 0.3, dampingFraction: 0.7),
        dragSensitivity: CGFloat = 500,
        allowHide: Bool = false
    ) {
        self.animation = animation
        self.dragSensitivity = dragSensitivity
        self.allowHide = allowHide
    }
}
