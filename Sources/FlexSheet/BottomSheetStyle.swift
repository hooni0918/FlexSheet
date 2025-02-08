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
        let itemHeight: CGFloat = 120
        let headerHeight: CGFloat = 60
        let additionalHeight: CGFloat = 84
        
        switch self {
        case .full:
            return screenHeight * 0.876
        case .half:
            return (itemHeight * 2) + headerHeight + additionalHeight
        case .minimal:
            return headerHeight
        case .notShow:
            return 0
        }
    }
}
