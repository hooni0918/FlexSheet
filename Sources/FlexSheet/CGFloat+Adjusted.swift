//
//  CGFloat+Adjusted.swift
//  FlexSheet
//
//  Created by 이지훈 on 2/9/25.
//

import UIKit

@MainActor
extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }
    
    var adjustedH: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 812
        return self * ratio
    }
}

@MainActor
extension Double {
    var adjusted: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 375)
        return self * ratio
    }
    
    var adjustedH: Double {
        let ratio: Double = Double(UIScreen.main.bounds.height / 812)
        return self * ratio
    }
}

@MainActor
extension Int {
    var adjusted: CGFloat {
        return CGFloat(self).adjusted
    }
    
    var adjustedH: CGFloat {
        return CGFloat(self).adjustedH
    }
}
