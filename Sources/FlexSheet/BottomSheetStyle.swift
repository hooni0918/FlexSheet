//
//  BottomSheetStyle.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//
//
import Foundation

@frozen
public enum BottomSheetStyle: Equatable {
    case full
    case half
    case minimal
    case notShow
    
    public func height(for screenHeight: CGFloat) -> CGFloat {
        switch self {
        case .full:
            return screenHeight * 0.85
        case .half:
            return screenHeight * 0.5
        case .minimal:
            return screenHeight * 0.25
        case .notShow:
            return 0
        }
    }
}
