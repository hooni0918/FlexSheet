// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@MainActor
public enum FlexSheet {
    public static let defaultAnimation: Animation = .spring(response: 0.3, dampingFraction: 0.7)
    public static let defaultDragSensitivity: CGFloat = 500.adjusted
    
    @MainActor
    public enum Constants {
        public static let handleBarHeight: CGFloat = 40.adjustedH
        public static let cornerRadius: CGFloat = 10.adjusted
        public static let handleBarWidth: CGFloat = 24.adjusted
        public static let handleBarThickness: CGFloat = 2.adjusted
    }
}
