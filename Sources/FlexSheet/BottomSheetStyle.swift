//
//  BottomSheetStyle.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//
//
import Foundation

@MainActor
@frozen
public enum BottomSheetStyle: Equatable {
    case full
    case half
    case minimal
    case notShow
    
    public func height(for screenHeight: CGFloat) -> CGFloat {
        let itemHeight: CGFloat = 120.adjusted
                let headerHeight: CGFloat = 60.adjustedH
                let tabBarHeight: CGFloat = 49.adjustedH
                let safeAreaBottom: CGFloat = 34.adjustedH
                let additionalHeight: CGFloat = (tabBarHeight + safeAreaBottom).adjustedH
                
        
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
