//
//  BottomSheetStyle.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//  Copyright © 2024 이지훈. All rights reserved.
//

import SwiftUI

@frozen
public enum BottomSheetStyle: Equatable {
    case full
    case half
    case minimal
    
    public func height(for screenHeight: CGFloat) -> CGFloat {
        switch self {
        case .full:
            return screenHeight * 0.9
        case .half:
            return screenHeight * 0.5
        case .minimal:
            return screenHeight * 0.25
        }
    }
}
